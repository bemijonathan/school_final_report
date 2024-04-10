function [problem, params] = Params() 
%% Problem Definition

problem.CostFunction = @(x, y) Himmelblau(x, y);    % Cost Function
problem.nVar = 2;              % Number of Decision Variables
problem.VarSize = [1 problem.nVar];     % Decision Variables Matrix Size
problem.VarMin = 0;            % Lower Bound of Decision Variables
problem.VarMax = 6;             % Upper Bound of Decision Variables
problem.Constraints = @(x1, x2, R) InequalityConstraints(x1,x2,R);                    % Constraint
problem.FitnessValue = @(x1, x2, R) problem.CostFunction(x1,x2) + problem.Constraints(x1,x2,R);       % Fitness Value


%% DE Parameters

params.MaxIt = 1000;       % Maximum Number of Iterations
params.nPop = 100;          % Population Size
params.beta_min = 0.2;     % Lower Bound of Scaling Factor (0)
params.beta_max = 0.8;     % Upper Bound of Scaling Factor (2)
params.pCR = 1;          % Crossover Probability
params.tolerance = 517.063;  % Tolerance value
params.pausing = false;
params.showContourPlot = true;
params.R = 10;

end 
