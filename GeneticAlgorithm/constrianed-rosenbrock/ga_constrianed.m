clear; clc; clf;

addpath('../shared')

%% Problem Definition (Minimization Problem we want to minimize the costfunction)

CostFunction = @(x1,x2) Himmelblau(x1,x2);                                      % Cost Function
Constraints = @(x1,x2,R) InequalityConstraints(x1,x2,R);                    % Constraint
problem.FitnessValue = @(x1,x2,R) CostFunction(x1,x2) + Constraints(x1,x2,R); 



% number of variables to be optimized  in real world problems example can be
% like designing an aircraft wing, the variables might include dimensions, materials, angles,
problem.numberVariables = 2;
problem.VarMin = 0;
problem.VarMax = 6;

%% Genetic Algorithm Parameters


% 1. Termination Criteria
params.maximumIteration = 5000;
params.populationSize = 20;
%  selection pressure
params.beta = 1;
% 3. Crossover Probability
params.crossOverProbability = 1;
% 4. Mutation Probability
params.mutationProbability = 0.02;
params.eliminationType = "FitnessBased";
% 5. Selection Method
params.selectionMethod = "Tournament";
% 6. Crossover Type
params.crossoverType  = "Single_Double_Uniform";
% 7. Mutation Type
params.mutationType = "BitFlip";
params.pausing = true;
params.R = 100;
params.tolerance =  10^-2;



%% Run GA
out = RunGA(problem, params);
% semilogy(out.bestcost, 'LineWidth', 2);
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

%% median after using the crossover operator
crossoverOperatorBMprops.titleText = 'Best Cost vs Iterations - TriplePoint Selection operator';
crossoverOperatorBMprops.operatorValue = 'TriplePoint';
crossoverOperatorBMprops.operatorType = 'crossoverType';

crossoverOperatorBenchmark = BenchMark(problem, params, crossoverOperatorBMprops);

%% median after using the elimination operator
eliminationOperatorBMprops.titleText = 'Best Cost vs Iterations - Random Elimination operator';
eliminationOperatorBMprops.operatorValue = 'RandomElimination';
eliminationOperatorBMprops.operatorType = 'eliminationType';

eliminationOperatorBenchmark = BenchMark(problem, params, eliminationOperatorBMprops);

%% median after using the mutation operator
mutationOperatorBMprops.titleText = 'Best Cost vs Iterations - single point mutation operator';
mutationOperatorBMprops.operatorValue = 'singlePoint';
mutationOperatorBMprops.operatorType = 'mutationType';

mutationOperatorBenchmark = BenchMark(problem, params, mutationOperatorBMprops);

%% Compare the Benchmarks A, B and C of the Min One problem
