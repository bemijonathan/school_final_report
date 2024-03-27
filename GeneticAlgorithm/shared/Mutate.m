function y = Mutate(x, mutationProbability, mutationType)

if mutationType == "singlePoint"
    y = SinglePointMutation(x, randi([0,1], size(x)), mutationProbability);
else
    flag = (rand(size(x)) < mutationProbability);
    y = x;
    y(flag) = 1 - x(flag);
end
end


function y = SinglePointMutation(x1, x2, crossoverProbability)

flag = (rand(size(x1)) < crossoverProbability);

y = x1;
y(flag) = x2(flag);

end