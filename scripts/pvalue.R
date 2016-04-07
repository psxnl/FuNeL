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

args<-commandArgs(TRUE)
path=(args[1])
score=paste(path, "scores.dat", sep="/")
score2=paste(path, "statistical_test.dat", sep="/")
data=read.table(score)

probs=cbind()
for(i in 1:length(data[,1])) {
    row=data[i,]
    p=pnorm(row$V2,mean=row$V3,sd=row$V4,lower.tail=F)
    probs=append(probs,p)
}
data$V5=probs
write.table(data,file=score2)
