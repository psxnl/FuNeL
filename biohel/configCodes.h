#ifndef _CONFIG_CODES_
#define _CONFIG_CODES_

#define PROB_CROSSOVER				10 
#define POP_SIZE				20 
#define ITERATIONS 				30
#define INITIALIZATION_MIN_CLASSIFIERS		40
#define INITIALIZATION_MAX_CLASSIFIERS		50
#define IGNORE_MISSING_VALUES 			60
#define DUMP_POPULATION 			70

#define SELECTION_ALGORITHM			80	
	#define TOURNAMENT_SELECTION		1
	#define TOURNAMENT_WOR_SELECTION	2
	#define PARETO_SELECTION		3
#define TOURNAMENT_SIZE 			90
#define SHOW_FRONTS 				100

#define CROSSOVER_OPERATOR			110
	#define CROSS_1P      			1
	#define CROSS_2P			2
	#define CROSS_INFORMED			3

#define FITNESS_FUNCTION 			130
	#define ACCURACY 			1
	#define MDL	 			2
#define MDL_WEIGHT_RELAX_FACTOR			140
#define MDL_ITERATION 				150
#define MDL_INITIAL_TL_RATIO 			170

#define MAX_MIN					180
	#define MAXIMIZE 			1
	#define MINIMIZE 			2

#define PRUNING_ITERATION	 		190
#define PRUNING_MIN_CLASSIFIERS			200
#define PRUNING_AUTO_THRESHOLD			205
#define PRUNING_AUTO_THRESHOLD2			206
#define PRUNING_AUTO_OFFSET			207

#define PROB_INDIVIDUAL_MUTATION 		210

#define HIERARCHICAL_SELECTION_ITERATION	220
#define HIERARCHICAL_SELECTION_THRESHOLD	230
#define HIERARCHICAL_SELECTION_USES_MDL		240

#define CHECK_WINDOWING				250
#define WINDOWING_ILAS 				260
#define WINDOWING_GWS 				270

#define PROB_ONE	 			280
#define PROB_SHARP	 			290

#define KR_ADI		 			300
#define PROB_MERGE 				310
#define PROB_SPLIT	 			320
#define PROB_REINITIALIZE			330
#define PROB_REINITIALIZE_AT_END		340
#define MAX_INTERVALS 				350
#define DUMP_DISCRETIZERS			360

#define KR_HYPERRECT	 			370
#define KR_HYPERRECT_LIST 			373
#define KR_HYPERRECT_LIST_REAL 			374
#define KR_HYPERRECT_SSE 			375
#define KR_ROTATED_HYPERRECT 			376
#define KR_HYPERRECT_LIST_PLUS 			377

#define KR_LCS					380
#define KR_INSTANCE_SET				390

#define D_OF_FR 				400
#define N_OF_SBX 				410
#define ALPHA_OF_BLX 				420

#define KR_GABIL				430

#define PENALIZE_MIN_SIZE			440
#define PENALIZE_MIN_SIZE_AT_END		450

#define TOTAL_TIME				460

#define DEFAULT_CLASS				470
	#define MAJOR 				-1
	#define MINOR				-2
	#define DISABLED			-3
	#define FIXED				-4

#define DUMP_EVOLUTION_STATS			480

#define PARETO_SELECTION_ITERATION		490

#define CLASS_WISE_INIT		500

#define PRUNING_POLICY			510
	#define FTB			1
	#define BTF			2
	#define RANDOM			3

#define HARD_NICHING_DISABLE			520

#define SMART_INIT				530
#define DUMP_ACTIVATION				540

#define CLASS_WISE_ACC				550

#define PROB_SMART_CROSSOVER			570
#define NUM_PARENTS_SMART_CROSSOVER		580

#define ADD_RULES_SMART_CROSSOVER		610
#define REPETITIONS_RULE_ORDERING		620
#define ELITISM_WITH_SMART_CROSSOVER		630
#define ELITISM_LAST_ITERATION_WITH_SMART_CROSSOVER		640


#define DUMP_GENOTYPE_ITERATIONS		650

#define FILTER_SMART_CROSSOVER			660
#define MDL_WEIGHT				670
#define RULE_CLEANING_PROB			680 
#define RULE_GENERALIZING_PROB			690 
#define INFORMED_CROSSOVER			700

#define COVERAGE_BREAKPOINT			710
#define REPETITIONS_RULE_LEARNING		720
#define COVERAGE_RATIO				730

#define ROTATE_HYPERRECTANGLES			740
#define RESTRICTED_ROTATED_ATTRIBUTES		750
#define PROB_0ANGLE_MUT				760
#define PROB_0ANGLE_INIT			770

#define COVERAGE_INIT				780
#define EXPRESSED_ATT_INIT			790

#define PROB_GENERALIZE_LIST			800
#define PROB_SPECIALIZE_LIST			810
#define HYPERRECT_LIST				820

#define MIN_INTERVAL_SIZE_INIT			830
#define MAX_INTERVAL_SIZE_INIT			840

#define DUMP_ATTRIBUTE_STATISTICS		850
#define MAX_RULES				860

#define USE_GREATER_THAN_PREDICATES		870

#define DOB_PARTITIONS_IN_WINDOWING		880


#endif
