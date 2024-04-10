
function [pop, BestSol] = InitializePopulation(problem, params)

    empty_individual.Position = [];
    empty_individual.Cost = [];

    BestSol.Cost = inf;    % Best Solution Cost 

    pop = repmat(empty_individual, params.nPop, 1); % Create Population Array
    % Initialize Population


    for i = 1:params.nPop 
        % variable random matrix between Varmin and Varmax [4 -3]
        pop(i).Position = unifrnd(problem.VarMin, problem.VarMax, problem.VarSize);
        % objective function value for each individual
        pop(i).Cost = problem.FitnessValue(pop(i).Position(1), pop(i).Position(2), params.R);
        % if the cost of the individual is less than the best solution cost
        if pop(i).Cost < BestSol.Cost
            BestSol = pop(i);
        end
    end

end

