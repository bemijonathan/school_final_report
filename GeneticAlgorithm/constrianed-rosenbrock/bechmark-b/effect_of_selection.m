%% Roulette Wheel Selection

problem.costFunction = @(x, y) Rosenbrock(x, y);

% number of variables to be optimized  in real world problems example can be
% like designing an aircraft wing, the variables might include dimensions, materials, angles,
problem.numberVariables = 2;

problem.VarMin = -5;            % Lower Bound of Decision Variables
problem.VarMax = 5;             % Upper Bound of Decision Variables

%% Genetic Algorithm Parameters


% 1. Termination Criteria
params.maximumIteration = 200;

params.populationSize = 40;
% 2. Selection pressure
params.beta = 1;
% 3. Crossover Probability
params.crossOverProbability = 1;
% 4. Mutation Probability
params.mutationProbability = 0.5;
params.eliminationType = "FitnessBased";
% 5. Selection Method
params.selectionMethod = "RouletteWheel";
% 6. Crossover Type
params.crossoverType  = "Single_Double_Uniform";
% 8. Crossover co-efficient Type
params.nc = 15; 
% 7. Mutation Type
params.mutationType = "BitFlip";
% polynomial mutation parameters for SBX
params.pMc = 20;
params.pausing = true;


PlotGAParameterEffects('maximumIteration', [50, 100, 150, 200, 250], problem, params, 1);
PlotGAParameterEffects('populationSize', [50, 100, 150, 500, 1000], problem, params, 2);
PlotGAParameterEffects('beta', linspace(-0.5, 2, 5), problem, params, 3);
PlotGAParameterEffects('crossOverProbability', linspace(-0.5, 2, 5), problem, params, 4);
PlotGAParameterEffects('mutationProbability', linspace(0.01, 0.1, 5),problem, params, 5);


%% Effect of selection operator
% median after using the tournament selection operator
selectorOperatorBMprops.titleText = 'Best Cost vs Iterations - Tournament Selection operator';
selectorOperatorBMprops.operatorValue = 'Tournament';
selectorOperatorBMprops.operatorType = 'selectionMethod';
selectorOperatorBenchmark = BenchMark(problem, params, selectorOperatorBMprops);