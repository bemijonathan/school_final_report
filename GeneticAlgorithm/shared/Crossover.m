function [y1, y2] = Crossover(x1, x2, method)
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
end
end