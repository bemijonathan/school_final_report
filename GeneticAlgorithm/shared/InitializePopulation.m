function [samplePopulationOutPut, bestSolution] = InitializePopulation(populationSize, numberVariables, costFunction, empty_individual)


% Best Solution Ever Found is infinty at the beginning
bestsol.Cost = inf;

% Initialization
samplePopulation = repmat(empty_individual, populationSize, 1); % [position =[] , cost = []] * populationSize

for i = 1:populationSize
    % Generate Random Solution
    samplePopulation(i).Position = randi([0, 1], 1, numberVariables); % [0, 1] * numberVariables
    % Evaluate Solution
    samplePopulation(i).Cost = costFunction(samplePopulation(i).Position); % cost = costFunction(position)
    % find the best solution from the cost function in the sample population
    if samplePopulation(i).Cost < bestsol.Cost
        bestsol = samplePopulation(i);
    end
end

samplePopulationOutPut = samplePopulation;
bestSolution = bestsol;

end