%  https://showme.redstarplugin.com/d/d:sud1wqri

function out = RunGA(problem, params)

% Template for Empty Individual
empty_individual.Position = [];
empty_individual.Cost = [];

% Problem
FitnessValue = problem.FitnessValue;

% Params
maximumIteration = params.maximumIteration;
populationSize = params.populationSize;
beta = params.beta;
selectionMethod = params.selectionMethod;
eliminationType = params.eliminationType;
mutationType = params.mutationType;
pausing = params.pausing;
showContourPlot = params.showContourPlot;

% probability cummulation
crossOverProbability = params.crossOverProbability;
%  (expected number of cross-overs) * 2 we need to make sure that it is even
    % totalNumberCrossOvers;

if params.eliminationType == "(n,y)-strategy"
    totalNumberCrossOvers = round(crossOverProbability*populationSize/2)*6;
else
    totalNumberCrossOvers = round(crossOverProbability*populationSize/2)*2;
end
    
mutationProbability = params.mutationProbability;

%  this gives us the population and the best solution found

% Best Cost of Iterations
bestcost = nan(maximumIteration, 1);  % [nan] * maximumIteration
lastBestCostIterationIndex = 0;

[pop, bestsol] = InitializePopulation(params, problem,  empty_individual);

% Main Genetic Algorithm process
for it = 1:maximumIteration
    
    
    % selection probabilities
    probs = CalculateSelectionProbability(pop, beta);
    % Initialize Offsprings Population (storage for offsprings) by creating an empty individual structure
    % 2 offsprings for each crossover
    childPopulation = repmat(empty_individual, totalNumberCrossOvers/2, 2);
    % Crossover
    for k = 1:totalNumberCrossOvers/2
        % Select Parents
        p1 = pop(Selection(probs, selectionMethod));
        p2 = pop(Selection(probs, selectionMethod));
       
        % Perform Crossover
        [childPopulation(k, 1).Position, childPopulation(k, 2).Position] = Crossover(p1.Position, p2.Position, params);
    end
    
    % Convert childPopulation to Single-Column Matrix
    childPopulation = childPopulation(:);
    
    % Mutation
    for l = 1:totalNumberCrossOvers
        % Perform Mutation
        childPopulation(l).Position = Mutate(childPopulation(l).Position, mutationProbability, problem, params, mutationType);
        % Evaluation
        childPopulation(l).Cost = FitnessValue(childPopulation(l).Position(1),childPopulation(l).Position(2), params.R);
        % Compare Solution to Best Solution Ever Found
        if childPopulation(l).Cost < bestsol.Cost
            bestsol = childPopulation(l);
            lastBestCostIterationIndex = it;
            % disp(it)
        end
    end
    
    pop = Elimination(pop, childPopulation, eliminationType, populationSize);
    
    % Update Best Cost of Iteration
    bestcost(it) = bestsol.Cost;
    
    % Display Itertion Information
    % disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(bestcost(it))]);

         if pausing
            % clf;
            % Plot;
            % pause(2);
        end
end


%
disp([ num2str(lastBestCostIterationIndex) ': lastBestCostIterationIndex '])

% Results
out.pop = pop;
out.bestsol = bestsol;
out.bestcost = bestcost;
out.lastBestCostIterationIndex = lastBestCostIterationIndex;

if showContourPlot
    Plot;
end

end