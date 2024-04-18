function output = InitializePopulation(problem, params)

% The Particle Template
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

FitnessValue = problem.FitnessValue;
numberOfVariables = problem.numberOfVariables;        % Number of Unknown (Decision) Variables
VarSize = [1 numberOfVariables];         % Matrix Size of Decision Variables
decisionVarLowerBound = problem.decisionVarLowerBound;	% Lower Bound of Decision Variables
decisionVarUpperBound = problem.decisionVarUpperBound;    % Upper Bound of Decision Variables

populationSize = params.populationSize;
% Create Population Array
particle = repmat(empty_particle, populationSize, 1);

% Initialize Global Best
GlobalBest.Cost = inf;

% Initialize Population Members
for i=1:populationSize
    
    % Generate Random Solution
    particle(i).Position = unifrnd(decisionVarLowerBound, decisionVarUpperBound, VarSize);
    
    % Initialize Velocity
    particle(i).Velocity = zeros(VarSize);
    
    % Evaluation
    particle(i).Cost = FitnessValue(particle(i).Position(1), particle(i).Position(2), params.R);
    
    % Update the Personal Best
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    
    % Update Global Best
    if particle(i).Best.Cost < GlobalBest.Cost
        GlobalBest = particle(i).Best;
    end
    
end

output.population = particle;
output.GlobalBest = GlobalBest;
end