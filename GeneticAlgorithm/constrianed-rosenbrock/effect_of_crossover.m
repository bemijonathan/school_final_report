clc; clear; close all;

addpath("../shared/")

%% Roulette Wheel Selection

problem.costFunction = @(x, y) Himmelblau(x, y);

problem.CostFunction = @(x, x2) Himmelblau(x, x2);
problem.Constraints = @(x1,x2,R) InequalityConstraints(x1,x2,R);                    % Constraint
problem.FitnessValue = @(x1,x2,R) problem.CostFunction(x1,x2) + problem.Constraints(x1,x2,R);       % Fitness Value


% number of variables to be optimized  in real world problems example can be
% like designing an aircraft wing, the variables might include dimensions, materials, angles,
problem.numberVariables = 2;
problem.VarMin = 0;            % Lower Bound of Decision Variables
problem.VarMax = 6;             % Upper Bound of Decision Variables

%% Genetic Algorithm Parameters

% 1. Termination Criteria
params.maximumIteration = 1000;
params.populationSize = 250;
params.beta = 1;
params.selectionMethod = "Tournament";
params.crossOverProbability = 0.75;
params.mutationProbability = 0.6;
params.crossoverType = "Linear";
params.nc = 15; 
params.mutationType = "polynomial";
params.eta_m = 15;
params.pausing = false;
params.showContourPlot = false;
params.eliminationType = "(n+y)-strategy";
params.R = 300;

%% Effect of selection operator on optimal value

medianBenchmark1Properties.titleText = 'Effect of Linear crossover operator - onHimmelblau Cost vs Iterations';
BenchMark(problem, params, medianBenchmark1Properties);
savePlot('effect_of_crossover_on_optimal_parameters_line.png')

%% contour plot
params.showContourPlot = true;
out = RunGA(problem, params);
savePlot('effect_of_crossover_on_optimnal_contour_plot.png')


