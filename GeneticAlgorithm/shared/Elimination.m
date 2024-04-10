function out =  Elimination  (pop, childPopulation, eliminationType, populationSize)
    if eliminationType == "(n+y)-strategy"
        % Merge and Sort Populations without eliminating
        pop = SortPopulation([pop; childPopulation], "");
        % Remove Extra Individuals
        out = pop(1:populationSize);
    else
        % (n,y)-strategy
        pop = SortPopulation([childPopulation], "");
        % Remove Extra Individuals
        out = pop(1:populationSize);
    end 
end