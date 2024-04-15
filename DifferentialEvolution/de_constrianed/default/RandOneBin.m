%% DE /rand/1/bin

function out = RandOneBin(problem , params)


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
R = params.R; 

FitnessValue = problem.FitnessValue;
VarSize = problem.VarSize;
VarMin = problem.VarMin;
VarMax = problem.VarMax;
OptimalSolution = problem.OptimalSolution;


BestCost = zeros(MaxIt, 1);
TolMinFlag = false;
TolMin = Inf;


for it = 1:MaxIt
    
    for i = 1:nPop
        
        x = pop(i).Position;    % Target Vector
        
        r = randperm(nPop);     % Indices for Random Vectors
        r(r == i) = [];         % Remove indices if equal to Target Vector
        
        % Mutant Vector (Mutation)
        beta = unifrnd(beta_min, beta_max, VarSize);
        v = pop(r(1)).Position + beta.*(pop(r(2)).Position - pop(r(3)).Position);   % Uses Three Random Vectors
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
        NewSol.Cost = FitnessValue(NewSol.Position(1), NewSol.Position(2), R);
        
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

       
    if  OptimalSolution - BestSol.Cost > tolerance && TolMinFlag == false
        disp(['Error below tolerance at iteration: ', num2str(it)]);
        TolMin = it;
        TolMinFlag = true;
    end
    
    % Show Iteration Information
    %disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);

     if pausing
        clf;
        Plot;
        pause(0.01)
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