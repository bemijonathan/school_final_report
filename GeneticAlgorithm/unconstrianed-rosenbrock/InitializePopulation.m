

function [samplePopulationOutPut, bestSolution] = InitializePopulation(params, problem, empty_individual)


% Best Solution Ever Found is infinty at the beginning
bestsol.Cost = inf;



% Initialization
samplePopulation = repmat(empty_individual, params.populationSize, 1); % [position =[] , cost = []] * populationSize

for i = 1:params.populationSize
    % Generate Random Solution
    samplePopulation(i).Position = unifrnd(problem.VarMin, problem.VarMax, problem.numberVariables); % [0, 1] * numberVariables
    % Evaluate Solution
    samplePopulation(i).Cost = problem.costFunction(samplePopulation(i).Position(1), samplePopulation(i).Position(2)); % cost = costFunction(position)
    % find the best solution from the cost function in the sample population
    if samplePopulation(i).Cost < bestsol.Cost
        bestsol = samplePopulation(i);
    end
end

samplePopulationOutPut = samplePopulation;
bestSolution = bestsol;

end

