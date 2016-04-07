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
import random
import sys

project = str(sys.argv[1])
rounds = int(sys.argv[2])

DATA = "results/"+project+"/data/"

class_list = []
for line in open(DATA + "data.arff"):
	if line.startswith("@") or line in ['\n', '\r\n', ' ']:
		continue
	class_list.append(line.split(",")[-1])


for i in range (1,rounds+1):
	random.shuffle(class_list)
	index = 0
	with open(DATA + "data_shuffled-"+str(i)+".arff", "wt") as output:
		for line in open (DATA + "data.arff"):
			if line.startswith("@") or  line in ['\n', '\r\n', ' ']:
				output.write(line)
				continue
			new_line = ""
			for value in line.split(",")[:-1]:
				new_line = new_line + value + ","
			new_line = new_line + class_list[index]
			index +=1
			output.write(new_line+"\n")




