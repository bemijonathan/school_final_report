function pop = SortPopulation(pop , method)
if method == "RandomElimination"
    pop = randomElimination(pop);
else
    [~, so] = sort([pop.Cost]);
    pop = pop(so);
end
end


function pop = randomElimination(pop)
n = length(pop);  % Total number of items in the population

% Calculate the number of items to remove (1/4 of the population)
numToRemove = round(n / 4);

% Randomly select unique indices to remove
indicesToRemove = randperm(n, numToRemove);

% Remove the selected indices
pop(indicesToRemove) = [];

% Sort the remaining population based on the Cost
[~, sortIndices] = sort([pop.Cost]);
pop = pop(sortIndices);
end
