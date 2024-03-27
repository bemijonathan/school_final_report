
function [newpop] = Selection(pop, type)
if type == "RouletteWheel"
    newpop = rouletteWheelSelection(pop);
elseif type == "Tournament"
    newpop = tournamentSelection(pop); 
else
    error('Invalid selection type');
end
end


function i = rouletteWheelSelection(p)

r = rand*sum(p);
c = cumsum(p);
i = find(r <= c, 1, 'first');

end

 % TOURNAMENTSELECTION Perform tournament selection from a population.
    % This function selects the best individual from a randomly chosen subset
    % of the population. Best is defined by having the lowest cost or fitness value
    % since this is a minimization problem.
function  i = tournamentSelection(p)

    tournamentSize =  2;
    populationLength = length(p);
    % randomly select tournamentSize individuals
    index = randi(populationLength, tournamentSize, 1); %[34, 54, 8]
    tournamentValues = p(index);
    [~, minIndex] = min(tournamentValues);% since it is a minimization problem, we use min here

    i = index(minIndex); % return the index of the winner

end