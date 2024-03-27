function [o1, o2] = TriplePointCrossOver(p1, p2)
numberVariables = numel(p1);
% Randomly select 3 points
points = sort(randperm(numberVariables, 3));
% Create the two offsprings, initially as copies of their parents
o1 = p1;
o2 = p2;
% Exchange segments between the two parents
[o1, o2] = exchangeSegments(o1, o2, points(1), points(2));
[o1, o2] = exchangeSegments(o1, o2, points(2), points(3));

end

% Helper function to exchange segments between offspring
function [o1, o2] = exchangeSegments(o1, o2, startIdx, endIdx)
segment1 = o1(startIdx:endIdx);
segment2 = o2(startIdx:endIdx);
o1(startIdx:endIdx) = segment2;
o2(startIdx:endIdx) = segment1;
end
