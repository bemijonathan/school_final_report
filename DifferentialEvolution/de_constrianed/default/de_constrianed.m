

clc; clear; close all; clf;
addpath('../../shared');

%% Initialization of problem and parameters
[problem, params] = Params();


% Show Results
% out = RandOneBin(problem, params);
% savePlot('default_constrained.png')

%% Plot line graph
% clf;
% plot(out.BestCost, 'LineWidth', 2);
% % mark the point of first minimum convergence
% hold on;
% if(out.TolMin ~= Inf)
%     plot(out.TolMin, out.BestCost(out.TolMin), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
% end
% xlabel('Iteration');
% ylabel('Best Cost');
% title('Best Cost vs Iterations - Himmelblau');
% grid on;
% legend('Best Cost', 'First Minimum Convergence' + string(out.TolMin));


%% Benchmark A
% this is the benchmark for the standard DE RandOneBin problem using the Himelblau function
% we plot 10 runs of the algorithm and take the median of
clf;
benchMarkMetaData.titleText = 'Best Cost vs Iterations - Himelblau';
benchMarkA = BenchMark(problem, params, benchMarkMetaData);


%% Optimal Parameters B
% this is the benchmark for the standard DE RandOneBin problem using the Himelblau function
% Call the function for each parameter, specifying the subplot index each time
RandOneBinattributes.problem = problem;
RandOneBinattributes.params = params;


PlotParameterEffects('MaxIt', [100, 200, 300, 400, 500], RandOneBinattributes, 1);
savePlot('effect_of_Parameters_MaxIt_on_Best_Cost_using_DE_rand_1_bin_Himelblau.png');
figure;
PlotParameterEffects('nPop', [50, 100, 150, 500, 1000], RandOneBinattributes, 2);
savePlot('effect_of_Parameters_nPop_on_Best_Cost_using_DE_rand_1_bin_Himelblau.png');
figure;
PlotParameterEffects('beta_min', linspace(-0.5, 2, 5), RandOneBinattributes, 3);
savePlot('effect_of_Parameters_beta_min_on_Best_Cost_using_DE_rand_1_bin_Himelblau.png');
figure;
PlotParameterEffects('beta_max', linspace(-1, 4, 5), RandOneBinattributes, 4);
savePlot('effect_of_Parameters_beta_max_on_Best_Cost_using_DE_rand_1_bin_Himelblau.png');
figure;
PlotParameterEffects('pCR', linspace(-0.5, 4, 5), RandOneBinattributes, 5);
savePlot('effect_of_Parameters_pC_on_Best_Cost_using_DE_rand_1_bin_Himelblau.png')
figure;
PlotParameterEffects('R', [10, 50 , 100 , 200, 250], RandOneBinattributes, 6)
savePlot('effect_of_Parameters__on_Best_Cost_using_DE_rand_1_bin_Himelblau.png')
figure;


% find the most efficient run
% then call the benchmark function

% maxIt -> 350
% nPop -> 1000
% beta_min -> 0.75
% beta_max -> 1.5
% pcR -> 1.75


%% set Optimal Parameters
[problem, params] = Params();
params.MaxIt = 300;
params.nPop = 100;
params.beta_min = 1;
params.beta_max = 1;
params.pCR = 1; 
params.R = 100;
% %% Benchmark B - With Optimal Parameters

benchMarkMetaData.titleText = 'Best Cost vs Iterations using DE/rand/1/bin - Himelblau';
benchMarkMetaData.DiffEvoAlgorithm = @(x, y) RandOneBin(x, y);
benchMarkB = BenchMark(problem, params, benchMarkMetaData);
savePlot('benchmark_of_optimal_penalty_on_rand_1_bin.png')


%% Benchmark C - DE/best/1/bin
% since




benchMarkMetaData.titleText = 'Best Cost vs Iterations using DE/best/1/bin - Himelblau';
benchMarkMetaData.DiffEvoAlgorithm = @(x, y) BestOneBin(x, y);
benchMarkCA = BenchMark(problem, params, benchMarkMetaData);
savePlot('benchmark_of_penalty_on_best_1_bin.png')


%% Benchmark CB - DE/best/2/bin
% since
[problem, params] = Params();
params.MaxIt = 400;
params.nPop = 150;
params.beta_min =0.4;
params.beta_max = 0.8;
params.pCR = 0.8;
params.R = 100;

benchMarkMetaData.titleText = 'Best Cost vs Iterations using DE/best/2/bin - Himelblau';
benchMarkMetaData.DiffEvoAlgorithm = @(x, y) BestTwoBin(x, y);
benchMarkCB = BenchMark(problem, params, benchMarkMetaData);
savePlot('benchmark_of_penalty_on_best_2_bin.png')

%% conclusion showing contour of 3 BenchMark

iterations = [1, 5, 10, 50 ];
params.showContourPlot = true;
params.contourSubPlotIndex = 1;

for i = iterations
    
    params.MaxIt = i;
    RandOneBin(problem, params);
    params.contourSubPlotIndex = params.contourSubPlotIndex + 1;
    
end
