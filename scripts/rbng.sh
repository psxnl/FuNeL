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
#  Rule Based Network Generation script                                #
########################################################################

#type:
# 0: generates networks using permutated datasets
# 1: generates networks using the original dataset
# 2: generates networks using only the strong nodes

projectname=$1
type=$2
NUM_BIOHEL_RUNS=$3
run=$4
conf=biohel/configuration.conf


if [ $type == 0 ]
then
	RESULTS=results/$projectname/results/permuted-$run
	DATA=results/$projectname/data/data_shuffled-$run.arff

elif [ $type == 1 ]
then
	RESULTS=results/$projectname/results/original
	DATA=results/$projectname/data/data.arff
else
	RESULTS=results/$projectname/results/2nd_training
	DATA=results/$projectname/data/strong_nodes.arff
fi

mkdir -p $RESULTS

for i in $(eval echo "{0..$NUM_BIOHEL_RUNS}")
do
	biohel/biohel $conf $DATA $DATA $RESULTS/run$i.out
	cat $RESULTS/run$i.out | scripts/network_generation/extract_rule_set.pl > $RESULTS/ruleSet$i.out
done

scripts/network_generation/att_rules.sh $RESULTS/ruleSet* | scripts/network_generation/count_diff.pl > $RESULTS/nodes.dat
grep Att $RESULTS/ruleSet* | scripts/network_generation/att_pairs.pl | scripts/network_generation/count_diff.pl > $RESULTS/edges.dat

if [ $type == 2 ]
then
	cut -d' ' -f1,2 $RESULTS/edges.dat > results/$projectname/co-prediction_network.txt
	exit
fi

rules=$(for (( i=0; i<$NUM_BIOHEL_RUNS; i++ )); do wc -l $RESULTS/ruleSet${i}.out; done | awk '{sum=sum+$1-1}END{print sum}')
awk -v r=$rules '{print $1,$2/r}' $RESULTS/nodes.dat > $RESULTS/nodes_freq.txt

