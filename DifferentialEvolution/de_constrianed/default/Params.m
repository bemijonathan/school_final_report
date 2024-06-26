function [problem, params] = Params() 
%% Problem Definition

problem.CostFunction = @(x, y) Himmelblau(x, y);    % Cost Function
problem.nVar = 20;              % Number of Decision Variables
problem.VarSize = [1 problem.nVar];     % Decision Variables Matrix Size
problem.VarMin = 0;            % Lower Bound of Decision Variables
problem.VarMax = 6;             % Upper Bound of Decision Variables
problem.Constraints = @(x1, x2, R) InequalityConstraints(x1,x2,R);                    % Constraint
problem.FitnessValue = @(x1, x2, R) problem.CostFunction(x1,x2) + problem.Constraints(x1,x2,R);       % Fitness Value
problem.OptimalSolution = 517.063;


%% DE Parameters

params.MaxIt = 500;       % Maximum Number of Iterations
params.nPop = 100;          % Population Size
params.beta_min = 0.2;     % Lower Bound of Scaling Factor (0)
params.beta_max = 0.8;     % Upper Bound of Scaling Factor (2)
params.pCR = 0.2;          % Crossover Probability
params.tolerance = 10^-2;  % Tolerance value
params.pausing = false;
params.showContourPlot = false;
params.R = 100;

end 
