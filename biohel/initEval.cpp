#include "configManagement.h"
#include "populationWrapper.h"
#include "classifierFitness.h"
#include "random.h"
#include "instanceSet.h"
#include "attributesInfo.h"
#include "lex_conf.h"
#include "timeManagement.h"
#include "messageBuffer.h"
#include "timersManagement.h"

messageBuffer mb;
attributesInfo ai;
configManagement cm;
instanceSet *is;
timeManagement timeM;
Random rnd;

int main(int argc, char *argv[])
{
	int i;

	if (argc < 4) {
		fprintf(stderr, "Incorrect parameters\n"
			"%s: <Config file> <Train file> <Test file>\n",
			argv[0]);
		exit(1);
	}

	if (argc == 5)
		mb.setFile(argv[4]);

	parseConfig(argv[1]);
	rnd.dumpSeed();
	is = new instanceSet(argv[2], TRAIN);
	timersManagement timers;

	int popSize = (int) cm.getParameter(POP_SIZE);
	populationWrapper pw(popSize);

	float aveAcc=0;
	classifier **population = pw.getPopulation();
	for(i=0;i<popSize;i++) {
		float acc = population[i]->getAccuracy2();
		aveAcc+=acc;
	}
	aveAcc/=(float)popSize;

	mb.printf("Average accuracy: %f\n",aveAcc);

}
