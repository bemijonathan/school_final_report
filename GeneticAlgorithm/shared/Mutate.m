 function y = Mutate(x, mutationProbability, problem, params,  mutationType)
     if mutationType == "singlePoint"
        y = SinglePointMutation(x, randi([0,1], size(x)), mutationProbability);
     elseif mutationType == "polynomial"
        y = PolynomialMutation(x, mutationProbability, problem, params);
     elseif mutationType == "Random"
        y = x;
        delta = (problem.VarMax - problem.VarMin);
        for i = 1:length(x)
          r = rand();
          if r < mutationProbability
            % Generate a random direction for the mutation
            direction = rand();
            if direction < 0.5
                % Add a random value to the gene
                y(i) = y(i) + rand() * delta;
            else
                % Subtract a random value from the gene
                y(i) = y(i) - rand() * delta;
            end
            
            % Ensure the mutated gene is within bounds
            y(i) = max(problem.VarMin, min(problem.VarMax, y(i)));
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
    r = offspring;
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
      r = offspring;
    end
 end