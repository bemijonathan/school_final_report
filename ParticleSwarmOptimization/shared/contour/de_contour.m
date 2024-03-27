%% DE/rand/1/bin
clc; clear; clf


%% Problem Definition

CostFunction = @(x1,x2) Sphere(x1,x2);                                      % Cost Function
nVar = 2;                                                                   % Number of Decision Variables
VarSize = [1 nVar];                                                         % Decision Variables Matrix Size
VarMin = -5;                                                                % Lower Bound of Decision Variables
VarMax = 5;                                                                 % Upper Bound of Decision Variables


%% DE Parameters

MaxIt = 10;        % Maximum Number of Iterations
nPop = 50;          % Population Size
F_min = 0.3;        % Lower Bound of Scaling Factor (0)
F_max = 0.3;        % Upper Bound of Scaling Factor (2)
pCR = 0.5;          % Crossover Probability
R = 1;             % Static Penalty Parameter
pausing = 1;        % If set to 1 (true), pause execution before next iteration until a key is pressed

%% Initialization

% Template for each individual
empty_individual.Position = [];
empty_individual.Cost = [];

% Initialise Best Solution Cost
BestSol.Cost = inf;

% Repeat Matrix for population using template
pop = repmat(empty_individual, nPop, 1);

for i = 1:nPop

    % Generation of Initial Random Population
    pop(i).Position = unifrnd(VarMin, VarMax, VarSize);

    % Evaluation of Initial Population
    pop(i).Cost = CostFunction(pop(i).Position(1), pop(i).Position(2));

    % Update Best Solution
    if (pop(i).Cost < BestSol.Cost)
        BestSol = pop(i);
    end

end

% Best Cost Vector Initialisation (for plot)
BestCost = zeros(MaxIt, 1);


%% DE Main Loop

for it = 1:MaxIt

    for i = 1:nPop

        % Target Vector
        x = pop(i).Position;

        % Mutant Vector (Mutation)
        r = randperm(nPop);                                                     % Indices for Random Vectors
        r(r == i) = [];                                                         % Remove indices if equal to Target Vector
        F = unifrnd(F_min, F_max, VarSize);                                     % Coefficient
        v = pop(r(1)).Position + F.*(pop(r(2)).Position - pop(r(3)).Position);  % Mutant Vector formula. Uses Three Random Vectors DE/rand/1/bin
        v = max(v, VarMin);                                                     % Applying lower bound
        v = min(v, VarMax);                                                     % Applying upper bound

        % Trial Vector (Crossover between Target Vector x and Mutant Vector v)
        u = zeros(size(x));                             % Initialisation
        j0 = randi(VarSize);                            % rnbr(i)
        for j = 1:nVar
            if (j == j0) || (rand <= pCR)               % Select Mutant or Target Vector to choose variable to be copied to Trial Vector
                u(j) = v(j);                            % Trial Vector variable copied from Mutant Vector
            else
                u(j) = x(j);                            % Trial Vector variable copied from Target Vector
            end
        end
        NewSol.Position = u;                            % Trial Vector
        NewSol.Cost = CostFunction(NewSol.Position(1), NewSol.Position(2));    % Function Evaluation

        % Selection between Trial Vector and Target Vector
        if (NewSol.Cost < pop(i).Cost)          % If Trial Vector is better than the Target Vector,
            pop(i) = NewSol;                    % Make the Target Vector equal to the Trial Vector

            % Update the Best Solution if needed
            if (pop(i).Cost < BestSol.Cost)
                BestSol = pop(i);               % Update the Best Solution
            end
        end

    end

    % Store Best Cost to Vector
    BestCost(it) = BestSol.Cost;

    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);

    % Pause execution before next iteration until a key is pressed
    if pausing
        clf;
        Draw;
        pause;
    end

end


%% Show Results

% Display Best Solution in Command Window
disp(BestSol)
x = BestSol.Position;

% First Subplot (Contour)
% subplot(2,1,1);
Draw

% % Second Subplot (Performance)
% subplot(2,1,2);
% 
% % Best Cost vs Iteration - Performance Graph
% semilogy(BestCost, 'LineWidth', 2);
% xlabel('Iteration');
% ylabel('Best Cost');
% grid on;

% Give focus to Command Window
pause(0.05);
commandwindow;
