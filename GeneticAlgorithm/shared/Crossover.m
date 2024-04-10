function [y1, y2] = Crossover(x1, x2, method, operator)
    if method == "TriplePoint"
        [y1, y2] = TriplePointCrossOver(x1, x2);
    elseif method == "Single_Double_Uniform"
        m = randi([1, 3]); % Randomly select a crossover method
        switch m
            case 1
                [y1, y2] = SinglePointCrossover(x1, x2);
                
            case 2
                [y1, y2] = DoublePointCrossover(x1, x2);
                
            otherwise
                [y1, y2] = UniformCrossover(x1, x2);
        end
    elseif method == "SBX"
        u = rand;
        if u <= 0.5
            beta = (2 * u) ^ (1 / (eta + 1));
        else
            beta = (1 / (2 * (1 - u))) ^ (1 / (eta + 1));
        end

        y1 = 0.5 * ((1 + beta) * parent1 + (1 - beta) * parent2);
        y2 = 0.5 * ((1 - beta) * parent1 + (1 + beta) * parent2);
    end
end