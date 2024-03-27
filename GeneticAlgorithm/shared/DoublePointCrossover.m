function [o1, o2] = DoublePointCrossover(p1, p2)

    numberVariables = numel(p1);
    
    q = randperm(numberVariables);
    j1 = min(q(1), q(2));
    j2 = max(q(1), q(2));
    
    o1 = [p1(1:j1) p2(j1+1:j2) p1(j2+1:end)];
    o2 = [p2(1:j1) p1(j1+1:j2) p2(j2+1:end)];

end