SUFFIX=
EXEC=biohel${SUFFIX}


OBJS=random.o classifier_gabil.o classifierFitness.o instanceSet.o \
	lex.yy.o instance.o timeManagement.o JString.o populationWrapper.o \
	timersManagement.o ga.o factory.o attributesInfo.o timerHierar.o \
	timerMDL.o timerSymbolicKR.o timerRealKR.o agentPerformance.o utils.o \
	timerGlobals.o timerMutation.o timerEvolutionStats.o windowingILAS.o \
	timerCrossover.o classifier_hyperrect.o mtwist.o \
	agentPerformanceTraining.o classifier_hyperrect_list.o windowingGWS.o \
	classifier_hyperrect_list_real.o classifier_hyperrect_list_plus.o
	#mt19937ar-cok.o

#CFLAGS=-Wno-deprecated -O3 -m64 -march=opteron
#CC=mpic++ -compiler intel

CFLAGS=-w -O3 -march=native
LDFLAGS=
CC=g++
LEX=flex

default: ${EXEC}

biohel${SUFFIX}: ${OBJS} main.o
	${CC} ${LDFLAGS} ${OBJS} main.o -o biohel${SUFFIX}

initEval: ${OBJS} initEval.o
	${CC} ${LDFLAGS} ${OBJS} initEval.o -o initEval

install: ${EXEC}
	cp ${EXEC} ${HOME}/bin

dep:
	${CC} -MM ${CFLAGS} *.cpp > .depend

.cpp.o:
	${CC} ${CFLAGS} -c $<

.c.o:
	${CC} ${CFLAGS} -c $<


clean:
	rm -f *.o core ${EXEC}

lex.yy.o: lex.yy.cpp configManagement.h dictionary.h configCodes.h \
  attributesInfo.h JString.h M95_types.h JVector.h instance.h random.h \
  mtwist.h messageBuffer.h
	${LEX} -i -olex.yy.cpp lex_conf.l
	${CC} ${CFLAGS} -c lex.yy.cpp

include .depend
