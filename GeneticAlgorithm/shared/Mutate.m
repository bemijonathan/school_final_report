 function y = Mutate(x, mutationProbability, problem,  mutationType)
     if mutationType == "singlePoint"
         y = SinglePointMutation(x, randi([0,1], size(x)), mutationProbability);
     else
 
          y = x;

          delta = (x.^problem.VarMax - x.^problem.VarMin);
          
          % Loop through each element of the solution
          for i = 1:length(x)
            % Generate a random number between 0 and 1
            r = rand();
            
            % Decide whether to mutate based on the random number
            if r < 0.5
              % Mutate the element by adding a random value between 0 and the delta
              y(i) = y(i) + r * delta(i);
            else
              % Mutate the element by subtracting a random value between 0 and the delta
              y(i) = y(i) - r * delta(i);
            end
            
            % Check if the element is outside the bounds
            if y(i) < problem.VarMin
              % Set the element to the lower bound
              y(i) = problem.VarMin;
            elseif y(i) > problem.VarMax
              % Set the element to the upper bound
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