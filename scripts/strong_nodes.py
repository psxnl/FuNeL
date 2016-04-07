#!/usr/bin/env python

# Copyright (C) 2014-2015 Nicola Lazzarini
# School of Computing Science, Newcastle University

# This file is part of the Functional Networks Learning (FuNeL) co-prediction protocol.

# FuNeL is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.

# FunNeL is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details:
# http://www.gnu.org/licenses/gpl.html

from collections import defaultdict
import numpy as np
import os
import sys

project_name = str(sys.argv[1])
num_perm_run = int(sys.argv[2])
second_training = int(sys.argv[3])

nodes_dict = defaultdict(list)
reference_dict = defaultdict(list)

final_nodes = []
nodes_list = []


# add reference frequencies
for line in open ("results/"+project_name+"/results/original/nodes_freq.txt"):
	reference_dict[line.split()[0]].append(float(line.split()[1]))

for result in range (1,num_perm_run+1):
	for line in open ("results/" + project_name + "/results/permuted-"+str(result)+"/nodes_freq.txt"):
		nodes_dict[line.split()[0]].append(float(line.split()[1]))


# prepare 5 col score file: name originalfreq avgrandomfreq stdrandomfreq
with open("results/"+project_name+"/results/scores.dat", "wt") as output:
	for key in reference_dict:
		if key not in nodes_dict:
			output.write("{0} {1} {2} {3}\n".format(key,reference_dict[key][0],0,0))
			continue
		not_appearance = num_perm_run - len(nodes_dict[key])
		nodes_dict[key] = nodes_dict[key] + [0]*not_appearance
		output.write("{0} {1} {2} {3}\n".format(key,reference_dict[key][0],np.mean(nodes_dict[key]),np.std(nodes_dict[key])))

# call R script to get p-values
os.system("Rscript scripts/pvalue.R " + "results/"+ project_name + "/results")

first=True
for line in open ("results/"+project_name+"/results/statistical_test.dat"):
	if first==True:
		first=False
		continue
	if line.split()[5].startswith("N"):
		continue
	if float(line.split()[5])<=0.05:
		final_nodes.append(line.split()[1][1:-1])

if len(final_nodes) == 0:
	print "There are no statistically significant nodes."
	sys.exit()
	
filtered_nodes = []
index_nodes = []
if second_training == 0:
	# create final graph
	with open("results/"+project_name+"/co-prediction_network.txt", "wt") as output:
		for line in open ("results/"+project_name+"/results/original/edges.dat"):
			source = line.split()[0]
			target = line.split()[1]
			weight = line.split()[2]
			if (source in final_nodes or target in final_nodes) and int(weight) > 0:
				if source not in filtered_nodes:
					filtered_nodes.append(source)
				if target not in filtered_nodes:
					filtered_nodes.append(target)
				output.write("{0} {1}\n".format(source,target))

else:
	previous_line = ""
	class_line = ""
	with open("results/"+project_name+"/data/strong_nodes.arff", "wt") as output:
		for line in open ("results/"+project_name+"/data/data.arff"):
			if line in ['\n', '\r\n', ' ']:
				continue
			if line.lower().startswith("@relation"):
				index = 0
				output.write(line)
				continue
			if line.lower().startswith("@attribute"):
				previous_line = line
				name = line.split()[1]
				if name in final_nodes:
					output.write(line)
					index_nodes.append(index)
				index += 1
				continue
			if line.startswith("\n"):
				continue

			if line.lower().startswith("@data"):
				class_line = previous_line
				output.write(class_line)
				output.write("@data\n")
				continue
			new_line = ""
			for i in range (0,len(line.split(","))):
				if i in index_nodes:
					new_line = new_line + line.split(",")[i] + ","
			output.write(new_line + line.split(",")[-1])
