clc; clear; close all;

addpath("../shared/")

%% Roulette Wheel Selection

problem.costFunction = @(x, y) Rosenbrock(x, y);

% number of variables to be optimized  in real world problems example can be
% like designing an aircraft wing, the variables might include dimensions, materials, angles,
problem.numberVariables = 2;
problem.VarMin = -5;            % Lower Bound of Decision Variables
problem.VarMax = 5;             % Upper Bound of Decision Variables

%% Genetic Algorithm Parameters

% 1. Termination Criteria
params.maximumIteration = 1000;
params.populationSize = 250;
params.beta = 1;
params.selectionMethod = "Tournament";
params.crossOverProbability = 0.75;
params.mutationProbability = 0.6;
params.crossoverType = "SBX";
params.nc = 15; 
params.mutationType = "Random";
params.eta_m = 15;
params.pausing = false;
params.showContourPlot = false;
params.eliminationType = "(n+y)-strategy";

%% Effect of selection operator on optimal value

medianBenchmark1Properties.titleText = 'Effect of Random Mutation operator - Rosenbrock Cost vs Iterations';
BenchMark(problem, params, medianBenchmark1Properties);
savePlot('optimal_parameters_line.png')

%% contour plot
params.showContourPlot = true;
out = RunGA(problem, params);
savePlot('optimnal_contour_plot.png')



