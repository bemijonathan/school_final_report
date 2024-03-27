function [o1, o2] = SinglePointCrossover(p1, p2)

    numberVariables = numel(p1);
    
    j = randi([1, numberVariables-1]);
    
    o1 = [p1(1:j) p2(j+1:end)];
    o2 = [p2(1:j) p1(j+1:end)];

end