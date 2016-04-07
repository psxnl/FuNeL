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
#  Generates a co-prediction functional network using one of the 4     #
#  available configurations.                                           #
########################################################################

# Parameters
WEKA_PATH=~/tools/weka-3-6-10/weka.jar
NUM_PERMUTATIONS=100
NUM_BIOHEL_RUNS=100

if [ $# -lt 3 ]
then
	echo "Wrong number of parameters"
	echo "Correct use: ./coprediction.sh <project_name> <dataset> <configuration> [<attributes>]"
	exit
fi

projectname=$1
dataset=$2
configuration=$3


mkdir -p results/$projectname/data
mkdir -p results/$projectname/results
cp $dataset results/$projectname/data/data.arff


# Check if the selected configuration require FS
if [ $configuration == 1 -o $configuration == 3 ]
then
	if [ $# -lt 4 ]
	then
		echo "Specify the number of attributes"
		echo "Correct use: ./coprediction.sh <project_name> <dataset> <configuration> [<attributes>]"
	exit
fi
	n_attributes=$4
	echo "Applying feature selection..."
	scripts/feature_selection.sh results/$projectname/data/data.arff $WEKA_PATH $n_attributes
fi

# Shuffle class labels and create random datasets

echo "Creating permuted datasets..."
scripts/permutations.sh $projectname $NUM_PERMUTATIONS

# Create Random Networks
# In order to speed-up the process run this loop in parallel

for run in `seq 1 $NUM_PERMUTATIONS`
do
	echo "Generating network for permuted dataset ("$run")..."
	scripts/rbng.sh $projectname 0 $NUM_BIOHEL_RUNS $run
done

# Create Original Network

echo "Generating network for the original dataset..."
scripts/rbng.sh $projectname 1 $NUM_BIOHEL_RUNS 0

# Get the Strong Nodes

if [ $configuration == 3 -o $configuration == 4 ]
then
	python scripts/strong_nodes.py $projectname $NUM_PERMUTATIONS 1
	if [ ! -f results/$projectname/data/strong_nodes.arff ]
	then
		echo "Impossible to generate the dataset for the 2nd learning phase."
		exit 0
	fi
else
	python scripts/strong_nodes.py $projectname $NUM_PERMUTATIONS 0
	if [ -f results/$projectname/co-prediction_network.txt ]
	then
		echo "Co-prediction network generated."
	else
		echo "Impossible to generate the co-prediction network."
		exit 0
	fi
fi

# Apply the second network generation phase whenever is required

if [ $configuration == 3 -o $configuration == 4 ]
then
	echo "Running the 2nd learning phase..."
	scripts/rbng.sh $projectname 2 $NUM_BIOHEL_RUNS 0
	echo "Co-prediction network generated."
fi
