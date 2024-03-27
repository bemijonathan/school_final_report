function [probs] = CalculateSelectionProbability(samplePopulation, beta)
populationSampleCost = [samplePopulation.Cost]; % get the cost of the population sample
populationAvarageCost = mean(populationSampleCost);
if populationAvarageCost ~= 0
    populationSampleCost = populationSampleCost/populationAvarageCost;
end
probs = exp(-beta*populationSampleCost);
end