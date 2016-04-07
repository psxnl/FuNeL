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
import sys

from collections import defaultdict

project_name = str(sys.argv[1])
mapping_file = str(sys.argv[2])
attributes = []
data = [] #list of list
classes = []
is_data = False

dictHUGO = {}
dictOriginal = defaultdict(list)

for line in open(mapping_file):
	ids = []
	if line.split()[1].startswith("No") or line.split()[1].startswith("Input"):
		ids.append("NoHugoID")
	else:
		for hugo_id in line.split()[1].split(";"):
			ids.append(hugo_id)
	dictHUGO[line.split()[0]]=ids

hugo_ids = []


with open("results/"+project_name+"/tmp.txt", "wt") as output:
	for line in open("results/"+project_name+"/co-prediction_network.txt"):
		node1 = ""
		orig_id1 = line.split()[0]
		node2 = ""
		orig_id2 = line.split()[1]
		for hugo_id in dictHUGO[orig_id1]:
			if not hugo_id.startswith("No") or hugo_id.startswith("Input"):
				node1 = node1 + hugo_id
				if hugo_id not in hugo_ids:
					hugo_ids.append(hugo_id)

		for hugo_id in dictHUGO[orig_id2]:
			if not hugo_id.startswith("No") or hugo_id.startswith("Input"):
				node2 = node2 + hugo_id
				if hugo_id not in hugo_ids:
					hugo_ids.append(hugo_id)

		if node1 == "" or node2 == "" or node1 == node2:
			continue
		new_line = "{0} {1}\n".format(node1, node2)
		output.write(new_line)

output.close()

dictEdges = defaultdict(list)


with open("results/"+project_name+"/co-prediction_network_final.txt", "wt") as output:
	for line in open("results/"+project_name+"/tmp.txt"):
		id1 = line.split()[0]
		id2 = line.split()[1]

		if id2 not in dictEdges[id1] and id1 not in dictEdges[id2]:
			output.write(line)
			dictEdges[id1].append(id2)
			dictEdges[id2].append(id1)
