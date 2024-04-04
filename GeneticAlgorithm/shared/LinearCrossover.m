function [offspring1,offspring2] = LinearCrossover(parent1, parent2)
%  LINEARCROSSOVER Summary of this function goes here
%  Detailed explanation goes here
%  first implemented by wright in 1991 2 parents produce 3 offsprings
%  and the best two is then selected

o1 = 0.5 .* (parent1 + parent2);
o2 = (1.5 .* parent1) - (0.5 .* parent2);
o3 = (-0.5 .* parent1) + (1.5 .* parent2);

% take the best two offspring


offsprings = [o1, o2, o3];

offspringsfitness = [
    Rosenbrock(o1(1), o1(2))
    Rosenbrock(o2(1), o2(2))
    Rosenbrock(o3(1), o3(2))
];


[~, indices] = sort(offspringsfitness, 'descend');

offspring1 = offsprings(:, indices(1));
offspring2 = offsprings(:, indices(2));

end


