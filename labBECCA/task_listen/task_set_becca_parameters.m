function task = task_set_becca_parameters( task)

task.agent.grouper.PROPENSITY_UPDATE_RATE = 10 ^ (-3.5);
task.agent.grouper.MAX_PROPENSITY = 0.2;
task.agent.grouper.GROUP_DISCOUNT = 2;

task.agent.grouper.NEW_GROUP_THRESHOLD = 0.02;
task.agent.grouper.MIN_SIG_CORR = 0.015;
task.agent.grouper.MAX_GROUP_SIZE = 9; 

task.agent.feature_map.NEW_FEATURE_MARGIN = 0.5; %0.35;

task.agent.planner.EXPLORATION_FRACTION = 0.0;
task.agent.planner.OBSERVATION_FRACTION = 1;
