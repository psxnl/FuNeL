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
##################################################
# Applies Feature Selection (SVM-RFE)            #
# using Weka implementation.                     #
# The number of attributes is set as parameter   #
##################################################

WEKA_PATH=$2

if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters"
    echo "Use: featureselection <data> <weka_path> <n_attributes>"
    exit
fi

n_attributes=$3
reducedfile="${1%.*}"Reduced.arff
java -cp $WEKA_PATH weka.filters.supervised.attribute.AttributeSelection -E "weka.attributeSelection.SVMAttributeEval -X 1 -Y 20 -Z 0 -P 1.0E-25 -T 1.0E-10 -C 1.0 -N 0" -S "weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N $n_attributes" -i $1 -o $reducedfile

# overwrite original data file
rm $1
mv $reducedfile $1
