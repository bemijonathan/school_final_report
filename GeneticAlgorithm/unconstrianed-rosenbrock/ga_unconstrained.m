clear; clc; clf; close all;

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
params.populationSize = 100;
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
params.pausing = false;
params.showContourPlot = false;


%% Run GA
out = RunGA(problem, params);
hold on;
plot(out.bestcost, 'LineWidth', 2);
xlabel('Iterations');
ylabel('Best Cost');
grid on;
hold off;

%% median bench mark after 5 iterations
medianBenchmark1Properties.titleText = 'Best Cost vs Iterations';
medianBenchmark1 = BenchMark(problem, params, medianBenchmark1Properties);

%% effect of parameters on the best cost Benchmark 2
figure;

attributes.problem = problem;
attributes.params = params;


% Call the function for each parameter, specifying the subplot index each time
PlotGAParameterEffects('maximumIteration', [50, 100, 250, 500, 1000],attributes, 1);
savePlot('effect_of_maxIteration.png');
figure;
PlotGAParameterEffects('populationSize', [50, 100, 250, 500, 1000],attributes,2);
savePlot('effect_of_population_size.png');
figure;
PlotGAParameterEffects('crossOverProbability', [0 0.25 0.6 0.75 1],attributes, 3);
savePlot('effect_of_crossover_propbability.png');
figure;
PlotGAParameterEffects('mutationProbability', [0 0.25 0.6 0.75 1],attributes, 4);
savePlot('effect_of_mutation_probability.png');
figure;
PlotGAParameterEffects('nc', [5 10 15 30 40], attributes, 5);
savePlot('effect_of_cross_over_operator.png');
figure;
PlotGAParameterEffects('eta_m', [5 10 15 30 40], attributes, 6);
savePlot('effect_of_mutation_operator.png');

%% Benchmark of all the optimal parameters

medianBenchmark1Properties.titleText = 'Optimal Parameters of RGA - Rosenbrock Cost vs Iterations';
% 1. Termination Criteria
params.maximumIteration = 1000;
params.populationSize = 250;
params.crossOverProbability = 0.75;
params.mutationProbability = 0.6;
params.nc = 15; 
params.eta_m = 15;

BenchMark(problem, params, medianBenchmark1Properties);
savePlot('optimal_parameters.png')

%% contour plot

params.showContourPlot = true;
out = RunGA(problem, params);
savePlot('optimnal_contour_plot.png')
