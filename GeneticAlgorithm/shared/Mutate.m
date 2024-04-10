 function y = Mutate(x, mutationProbability, problem, params,  mutationType)
     if mutationType == "singlePoint"
        y = SinglePointMutation(x, randi([0,1], size(x)), mutationProbability);
     elseif mutationType == "Polynomial"
        y = PolynomialMutation(x, mutationProbability, problem, params);
     elseif mutationType == "Radom"
        y = x;
        delta = (x.^problem.VarMax - x.^problem.VarMin);
        for i = 1:length(x)
          r = rand();
          if r < 0.5
            y(i) = y(i) + r * delta(i);
          else
            y(i) = y(i) - r * delta(i);
          end
          if y(i) < problem.VarMin
            y(i) = problem.VarMin;
          elseif y(i) > problem.VarMax
            y(i) = problem.VarMax;
          end
        end
     end
 end
 
 
 function y = SinglePointMutation(x1, x2, crossoverProbability)
    flag = (rand(size(x1)) < crossoverProbability);
    y = x1;
    y(flag) = x2(flag);
 end

 function r =  PolynomialMutation(offspring, mutationProbability, problem, params)
    randomNumber = rand();
    if randomNumber > mutationProbability
      for i = 1:length(offspring)
        rj = rand();
        d = inf;
        if rj > 0.5
          d = (2 * rj) .^ ( 1 / (params.eta_m + 1)) - 1;
        else
          d = 1 - (2 * (1 - rj)) .^ (1 / (params.eta_m + 1));
        end
        offspring(i) = offspring(i) + (problem.VarMax - problem.VarMin) * d;
        if offspring(i) < problem.VarMin
          offspring(i) = problem.VarMin;
        end
        if offspring(i) > problem.VarMax
          offspring(i) = problem.VarMax;
        end 
      end
    end
    r = offspring;
 end