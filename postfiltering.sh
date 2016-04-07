#!/bin/bash

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

########################################################################
#  Applies a post filter to map each probe with its relative gene.     #
#  It requires a 2 columns text mapping file: probe_id   gene_id       #
########################################################################

if [ $# -lt 2 ]; then
	echo "Wrong number of parameters"
	echo "Correct use: ./postfiltering.sh <project_name> <mapping>"
	exit
fi

python scripts/postfiltering.py $1 $2

rm projects/$1/tmp.txt
