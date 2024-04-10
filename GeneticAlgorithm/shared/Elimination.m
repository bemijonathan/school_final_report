function out =  Elimination  (pop, childPopulation, eliminationType, populationSize)
    if eliminationType == "(n+y)-strategy"
        % Merge and Sort Populations without eliminating
        pop = SortPopulation([pop; childPopulation], "");
        % Remove Extra Individuals
        out = pop(1:populationSize);
    else
        % childPopulation = repmat(struct('Position', []), populationSize, 2);
        % % (n,y)-strategy
        % if populationSize > length(pop)
        %     %  generate 20 more children
        %     [childPopulation(k, 1).Position, childPopulation(k, 2).Position] = Crossover(p1.Position, p2.Position, params);
        % end 
        pop = SortPopulation(childPopulation, "");
        % Remove Extra Individuals
        out = pop(1:populationSize);
    end 
end