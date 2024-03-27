
clc; clear; clf;

addpath('./shared/');

%% Problem Definiton

problem = setupOptimizationProblem();
params = setupPSOParams();
ccParams = setUpConstrictionCoefficients();
population = InitializePopulation(problem, params);

%% Calling PSO
out = PSO(problem, params, population); % Execute standard PSO algorithm
BestSol = out.BestSol; % Best Solution
BestCosts = out.BestCosts; % Best Costs

%% Results
% results show the convergence of the algorithm
plot(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
title('Best Cost vs Iterations - Rosenbrock');
grid on;

%% Benchmark A
% this is the benchmark for the standard PSO algorithm
% we plot 10 runs of the algorithm and take the median of

benchMarkMetaData.titleText = 'Best Cost vs Iterations - Rosenbrock';
benchMarkA = BenchMark(problem, params, benchMarkMetaData);


%%  Benchmark B
% Effect of parameters on the code
figure;

% using uniform population we want to see the effect of different range on
% the same population
SPOattributes.population = population;
SPOattributes.problem = problem;
SPOattributes.params = params;

% Call the function for each parameter, specifying the subplot index each time
PlotPSOParameterEffects('maximumIteration', [50, 100, 150, 200, 250], SPOattributes, 1);
PlotPSOParameterEffects('populationSize', [50, 100, 150, 500, 1000], SPOattributes, 2);
PlotPSOParameterEffects('inertiaCoefficient', linspace(-0.5, 2, 5), SPOattributes, 3);
PlotPSOParameterEffects('personalAccCoefficient', linspace(-1, 4, 5), SPOattributes, 4);
PlotPSOParameterEffects('socialAccCoefficient', linspace(-0.5, 4, 5), SPOattributes, 5);

% find the most efficient run
% then call the benchmark function


%% Benchmark C

benchMarkCMetaData.titleText = 'Best Cost vs Iterations - Rosenbrock showing effect of constriction coefficient';
benchMarkC = BenchMark(problem, ccParams, benchMarkCMetaData);


%% Parameters and params

function z = setupOptimizationProblem()
z.CostFunction = @(x, x2) Rosenbrock(x, x2);
z.numberOfVariables = 2;
z.decisionVarLowerBound = -10;
z.decisionVarUpperBound = 10;
end

function p = setupPSOParams()
p.MaxIt = 100;        % Maximum Number of Iterations
p.populationSize = 50;           % Population Size (Swarm Size)
% Intertia Coefficient - Determines the level of exploration or
% exploitation of the particle size in the population.
p.inertiaCoefficient = 1;
% Damping Ratio of Inertia Coefficient used to reduce the velocity
% of the inertia coefficient as it goes through the iteration
p.wdamp = 0.99;
% Personal Acceleration Coefficient is the first part of the PSO.
% it determines the accelation of the particle towards the local best.
p.personalAccCoefficient = 2;
% It determins the  accelation of the particle towards the global best
p.socialAccCoefficient = 2;


p.tol  = 10^-2; % Theoritical Minimum Value for the Cost Function
p.velocityControl = 0.2; % Velocity Control Coefficient

% plot controls
% Other inline code parameters
% these are not actual paramters but will be used to plot the graphs.
p.ShowIterInfo = false; % Flag for Showing Iteration Informatin
% if true show progression of the contour plot per generation
p.pausing = true;
% if true shows the contour plot
p.showContourPlot = true;

end

function cc = setUpConstrictionCoefficients()
% Define Constriction Coefficients
% Initialize kappa, a constant used in the calculation of constriction coefficient.
kappa = 1;

% phi1 and phi2 represent cognitive and social coefficients respectively.
phi1 = 2.05;
phi2 = 2.05;

% Calculate the sum of cognitive and social coefficients.
phi = phi1 + phi2;

% Compute the constriction coefficient chi using Clerc and Kennedy's formula.
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

% Setup PSO parameters by calling a custom function setupPSOParams.
cc = setupPSOParams();

% Assign the calculated constriction coefficient chi to the inertiaCoefficient.
cc.inertiaCoefficient = chi; % Intertia Coefficient from Constriction Coefficients

% Calculate and assign personal acceleration coefficient, 
% scaled by constriction coefficient chi.
cc.personalAccCoefficient = chi*phi1; % Personal Acceleration Coefficient from Constriction Coefficients

% Calculate and assign social acceleration coefficient, 
% scaled by constriction coefficient chi.
cc.socialAccCoefficient = chi*phi2; % Social Acceleration Coefficient from Constriction Coefficients
end

