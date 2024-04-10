function [problem, params] = Params() 
%% Problem Definition

problem.CostFunction = @(x, y) Rosenbrock(x, y);    % Cost Function
problem.nVar = 2;              % Number of Decision Variables
problem.VarSize = [1 problem.nVar];     % Decision Variables Matrix Size
problem.VarMin = -5;            % Lower Bound of Decision Variables
problem.VarMax = 5;             % Upper Bound of Decision Variables

%% DE Parameters

params.MaxIt = 100;       % Maximum Number of Iterations
params.nPop = 50;          % Population Size
params.beta_min = 0.2;     % Lower Bound of Scaling Factor (0)
params.beta_max = 0.8;     % Upper Bound of Scaling Factor (2)
params.pCR = 0.2;          % Crossover Probability
params.tolerance = 10^-2;  % Tolerance value
params.pausing = false;
params.showContourPlot = false;

end 