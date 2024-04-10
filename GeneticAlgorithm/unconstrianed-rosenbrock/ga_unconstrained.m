clear; clc;

addpath('../shared')

%% Problem Definition (Minimization Problem we want to minimize the costfunction)
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
params.eliminationType = "(n+y)-strategy";
% 5. Selection Method
params.selectionMethod = "Tournament";
% 6. Crossover Type
params.crossoverType = "SBX";
% 8. Crossover co-efficient Type
params.nc = 15; 
% 7. Mutation Type
params.mutationType = "polynomial";
% eta_m is the distribution index for mutation
params.eta_m = 20;
params.pausing = true;


%% Run GA
out = RunGA(problem, params);
% plot(out.bestcost, 'LineWidth', 2);
% xlabel('Iterations');
% ylabel('Best Cost');
% grid on;


%% median bench mark after 5 iterations
medianBenchmark1Properties.titleText = 'Best Cost vs Iterations';
medianBenchmark1 = BenchMark(problem, params, medianBenchmark1Properties);

%% effect of parameters on the best cost Benchmark 2
figure;
% Call the function for each parameter, specifying the subplot index each time
PlotGAParameterEffects('maximumIteration', [50, 100, 150, 200, 250], problem, params, 1);
PlotGAParameterEffects('populationSize', [50, 100, 150, 500, 1000], problem, params, 2);
PlotGAParameterEffects('beta', linspace(-0.5, 2, 5), problem, params, 3);
PlotGAParameterEffects('crossOverProbability', linspace(-0.5, 2, 5), problem, params, 4);
PlotGAParameterEffects('mutationProbability', linspace(0.01, 0.1, 5),problem, params, 5);

%% Effect of operators on the GA performance - Benchmark 3
% median after using the tournament selection operator
selectorOperatorBMprops.titleText = 'Best Cost vs Iterations - Tournament Selection operator';
selectorOperatorBMprops.operatorValue = 'Tournament';
selectorOperatorBMprops.operatorType = 'selectionMethod';
selectorOperatorBenchmark = BenchMark(problem, params, selectorOperatorBMprops);
