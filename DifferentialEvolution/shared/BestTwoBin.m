%% DE/best/2/bin a Mutate the best individual in the population

function out = BestTwoBin(problem , params)


    % initialize population
    [pop, BestSol] = InitializePopulation(problem, params);
    
    % destructure parameters
    MaxIt = params.MaxIt;       
    nPop = params.nPop;         
    beta_min = params.beta_min;    
    beta_max = params.beta_max;    
    pCR = params.pCR;         
    tolerance = params.tolerance;
    pausing = params.pausing;
    showContourPlot = params.showContourPlot;
    
    CostFunction = problem.CostFunction;
    VarSize = problem.VarSize;
    VarMin = problem.VarMin;
    VarMax = problem.VarMax;
    
    
    BestCost = zeros(MaxIt, 1);
    TolMinFlag = false;
    TolMin = Inf;
    
    
    for it = 1:MaxIt
        
        for i = 1:nPop
            
            x = pop(i).Position;    % Target Vector
            
            r = randperm(nPop);     % Indices for Random Vectors
            r(r == i) = [];         % Remove indices if equal to Target Vector
            
            % Finding the best individual in the population
            [~, bestIdx] = min([pop.Cost]);
            bestIndividual = pop(bestIdx).Position;

            % Mutant Vector (Mutation) for DE/best/2/bin
            beta = unifrnd(beta_min, beta_max, VarSize);
            v = bestIndividual + beta.*(pop(r(1)).Position - pop(r(2)).Position) + beta.*(pop(r(3)).Position - pop(r(4)).Position); % Uses Best and Four Random Vectors
            v = max(v, VarMin);
            v = min(v, VarMax);
            
            % Trial Vector (Crossover between Target Vector x and Mutant Vector v)
            u = zeros(size(x));
            j0 = randi([1 numel(x)]);   % rnbr(i)
            for j = 1:numel(x)
                if j == j0 || rand <= pCR
                    u(j) = v(j);        % Trial Vector variable from Mutant Vector
                else
                    u(j) = x(j);        % Trial Vector variable from Target Vector
                end
            end
            
            NewSol.Position = u;
            NewSol.Cost = CostFunction(NewSol.Position(1), NewSol.Position(2));
            
            % Selection
            if NewSol.Cost<pop(i).Cost
                pop(i) = NewSol;
                
                if pop(i).Cost<BestSol.Cost
                   BestSol = pop(i);
                end
            end
            
        end
        
        % Update Best Cost
        BestCost(it) = BestSol.Cost;
    
           
        % this is reffered to as the minimum tolerance for the cost value
        if BestSol.Cost < tolerance && TolMinFlag == false
            disp(['Lower than tolerance: ', num2str(it)]);
            TolMin = it;
            TolMinFlag = true;
        end
        
        % Show Iteration Information
        %disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
         if pausing
            clf;
            Plot;
            pause;
        end
        
        
    end
    
    disp("TolMin == " + TolMin);
    
    out.BestCost = BestCost;
    out.BestSol = BestSol;
    out.TolMin = TolMin;
    
    if showContourPlot
        Plot;
    end
    
    end 