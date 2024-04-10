function [y1, y2] = Crossover(x1, x2, params)
    method = params.crossoverType;
    eta = params.nc;
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
        y1 = 0.5.*((x1 + x2) - eta * (x2 - x1));
        y2 = 0.5.*((x1 + x2) + eta * (x2 - x1));
    end
end