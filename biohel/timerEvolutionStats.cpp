#include "populationWrapper.h"
#include "timerEvolutionStats.h"
#include "timerGlobals.h"
#include "messageBuffer.h"
#include "utils.h"

extern messageBuffer mb;
extern timerGlobals *tGlobals;
extern double percentageOfLearning;

timerEvolutionStats::timerEvolutionStats()
{
	int i;

	iterationsSinceBest = 0;
	globalIterationsSinceBest = 0;
	maxMin = (int) cm.getParameter(MAX_MIN);
	doDumpStats=cm.thereIsParameter(DUMP_EVOLUTION_STATS);
	doDumpStatsAtts=cm.thereIsParameter(DUMP_ATTRIBUTE_STATISTICS);
}

timerEvolutionStats::~timerEvolutionStats()
{
}

int timerEvolutionStats::getGlobalIterationsSinceBest()
{
	return globalIterationsSinceBest;
}

int timerEvolutionStats::getIterationsSinceBest()
{
	return iterationsSinceBest;
}

void timerEvolutionStats::resetBestStats()
{
	iterationsSinceBest=0;
}

void timerEvolutionStats::reinit()
{
	iterationsSinceBest = 0;
	globalIterationsSinceBest = 0;
}

void timerEvolutionStats::bestOfIteration(int iteration,
					  double iterationBestFitness,
					  double iterationBestAcc)
{
	if (!iterationsSinceBest) {
		globalIterationsSinceBest++;
		bestFitness = iterationBestFitness;
		iterationsSinceBest = 1;
	} else {
		int newBest = 0;
		if (maxMin == MAXIMIZE) {
			if (iterationBestFitness > bestFitness)
				newBest = 1;
		} else {
			if (iterationBestFitness < bestFitness)
				newBest = 1;
		}

		if (newBest) {
			bestFitness = iterationBestFitness;
			iterationsSinceBest = 1;
			globalIterationsSinceBest = 1;
			//mb.printf("Iteration %d, New best fitness\n",
			//	iteration);
		} else {
			iterationsSinceBest++;
			globalIterationsSinceBest++;
		}
	}
}

void timerEvolutionStats::dumpStats(int iteration)
{
	classifier *ind = pw->getBestOverall();
	double aveAcc,devAcc;
	int i;
	pw->getAverageDevAccuracy(aveAcc,devAcc);

	if(doDumpStats || iteration==0) {
		mb.printf("It %d,Best ac:%f %f fi:%f."
			" Ave ac:%f,%f\n", iteration, ind->getAccuracy()
			,ind->getAccuracy2(),ind->getFitness(),aveAcc,devAcc);

		  if(doDumpStatsAtts) {
			   int numAtts=tGlobals->numAttributesMC;
			   double stats[numAtts*3];
			   pw->dumpAttStatsBest(stats);
 
			   for(i=0;i<numAtts;i++) {
				    mb.printf("It %d,Att %d: %f %f %f\n",iteration,i,stats[i],stats[i+numAtts],stats[i+numAtts*2]);
			   }
		  }

	}

	bestOfIteration(iteration, ind->getFitness(), ind->getAccuracy());
}
