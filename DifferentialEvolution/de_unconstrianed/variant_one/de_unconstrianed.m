

clc; clear; close all; clf;

addpath("../../shared")

%% Initialization of problem and parameters
[problem, params] = Params();

% Show Results
out = BestTwoBin(problem, params);

%% Plot line graph
clf;
plot(out.BestCost, 'LineWidth', 2);
% mark the point of first minimum convergence
hold on;
if(out.TolMin ~= Inf)
    plot(out.TolMin, out.BestCost(out.TolMin), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
end
xlabel('Iteration');
ylabel('Best Cost');
title('Best Cost vs Iterations - Rosenbrock');
grid on;
legend('Best Cost', 'First Minimum Convergence' + string(out.TolMin));


%% Benchmark A
% this is the benchmark for the standard DE RandOneBin problem using the Himelblau function
% we plot 10 runs of the algorithm and take the median of
clf;
benchMarkMetaData.titleText = 'Best Cost vs Iterations - Rosenbrock';
benchMarkA = BenchMark(problem, params, benchMarkMetaData);


%% Optimal Parameters B
% this is the benchmark for the standard DE RandOneBin problem using the Himelblau function
% Call the function for each parameter, specifying the subplot index each time
RandOneBinattributes.problem = problem;
RandOneBinattributes.params = params;

PlotBinParameterEffects('MaxIt', [100, 200, 300, 400, 500, 600], RandOneBinattributes, 1);
figure
PlotBinParameterEffects('nPop', [50, 100, 150, 500, 1000, 1300], RandOneBinattributes, 2);
figure
PlotBinParameterEffects('beta_min', linspace(0, 1, 6), RandOneBinattributes, 3);
figure
PlotBinParameterEffects('beta_max', linspace(0, 1, 6), RandOneBinattributes, 4);
figure
PlotBinParameterEffects('pCR', linspace(0, 1, 6), RandOneBinattributes, 5);


% find the most efficient run
% then call the benchmark function

% maxIt -> 350
% nPop -> 1000
% beta_min -> 0.75
% beta_max -> 1.5
% pcR -> 1.75


%% set Optimal Parameters
[problem, params] = Params();
params.MaxIt = 400;
params.nPop = 150;
params.beta_min =0.4;
params.beta_max = 0.8;
params.pCR = 0.8;

%% Benchmark B - With Optimal Parameters

benchMarkMetaData.titleText = 'Best Cost vs Iterations using DE/rand/1/bin - Himelblau';
benchMarkMetaData.DiffEvoAlgorithm = @(x, y) RandOneBin(x, y);
benchMarkB = BenchMark(problem, params, benchMarkMetaData);


%% Benchmark C - DE/best/1/bin
% since

benchMarkMetaData.titleText = 'Best Cost vs Iterations using DE/best/1/bin - Himelblau';
benchMarkMetaData.DiffEvoAlgorithm = @(x, y) BestOneBin(x, y);
benchMarkCA = BenchMark(problem, params, benchMarkMetaData);


%% Benchmark CB - DE/best/2/bin
% since

benchMarkMetaData.titleText = 'Best Cost vs Iterations using DE/best/2/bin - Himelblau';
benchMarkMetaData.DiffEvoAlgorithm = @(x, y) BestTwoBin(x, y);
benchMarkCB = BenchMark(problem, params, benchMarkMetaData);

%% conclusion showing contour of 3 BenchMark

iterations = [1, 75, 150, 300];
params.showContourPlot = true;

for i = iterations
    
    params.MaxIt = i;
    figure;
    RandOneBin(problem, params);
    figure;
    BestOneBin(problem, params);
    figure;
    BestTwoBin(problem, params);
    
end
