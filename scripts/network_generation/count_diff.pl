#!/usr/bin/perl -w

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

use strict;

my %counts;
my $total=0;
while(<STDIN>) {
	chomp;
	$counts{$_}++;
	$total++;
}

my @sorted = sort { $counts{$a} <=> $counts{$b} } keys %counts;

my $num=@sorted;
foreach(@sorted) {
	my $prop= sprintf "%d", $counts{$_};
	print "$_ $prop\n";
}
