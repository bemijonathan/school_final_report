function out = PSO(problem, params, population)

%% Problem Destructuring
CostFunction = problem.CostFunction;% Cost Function which is Rosenbrock in this scenerio
numberOfVariables = problem.numberOfVariables;        % Number of Unknown (Decision) Variables
VarSize = [1 numberOfVariables];         % Matrix Size of Decision Variables
decisionVarLowerBound = problem.decisionVarLowerBound;	% Lower Bound of Decision Variables
decisionVarUpperBound = problem.decisionVarUpperBound;    % Upper Bound of Decision Variables

%% Parameters of PSO
MaxIt = params.MaxIt;   % Maximum Number of Iterations
velocityControl = params.velocityControl; % Velocity Control
populationSize = params.populationSize;     % Population Size (Swarm Size)
inertiaCoefficient = params.inertiaCoefficient;           % Inertia Coefficient
wdamp = params.wdamp;   % Damping Ratio of Inertia Coefficient
personalAccCoefficient = params.personalAccCoefficient;         % Personal Acceleration Coefficient
socialAccCoefficient = params.socialAccCoefficient;         % Social Acceleration Coefficient

%% Population Initialization
particle = population.population;
GlobalBest = population.GlobalBest;

% The Flag for Showing Iteration Information
ShowIterInfo = params.ShowIterInfo;

MaxVelocity = velocityControl*(decisionVarUpperBound-decisionVarLowerBound);
MinVelocity = -MaxVelocity;
pausing = params.pausing;
showContourPlot = params.showContourPlot;

TolMinFlag = false;
TolMin = Inf;

% Array to Hold Best Cost Value on Each Iteration
BestCosts = zeros(MaxIt, 1);

%% Main Loop of PSO
for it=1:MaxIt
    
    for i=1:populationSize
        
        % Update Velocity (Inertia Coefficient, Personal Acceleration Coefficient, Social Acceleration Coefficient)
        %  V(i) = w*V(i) + c1*rand()*(Pbest(i)-X(i)) + c2*rand()*(Gbest-X(i))
        particle(i).Velocity = inertiaCoefficient*particle(i).Velocity ...
            + personalAccCoefficient*rand(VarSize).*(particle(i).Best.Position - particle(i).Position) ...
            + socialAccCoefficient*rand(VarSize).*(GlobalBest.Position - particle(i).Position);
        
        % Apply Velocity Limits
        %  V(i) = max(V(i),MinVelocity)
        particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
        particle(i).Velocity = min(particle(i).Velocity, MaxVelocity);
        
        % Update Position
        % X(i) = X(i) + V(i)
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Apply Lower and Upper Bound Limits
        % X(i) = max(X(i),VarMin)
        % if the value of X(i) is less than the lower bound, then X(i) = lower bound vice versa
        particle(i).Position = max(particle(i).Position, decisionVarLowerBound);
        particle(i).Position = min(particle(i).Position, decisionVarUpperBound);
        
        % Evaluation
        % calculate the cost of the current position for the particle
        particle(i).Cost = CostFunction(particle(i).Position(1), particle(i).Position(2));
        
        % Update Personal Best
        % if the cost of the current position is less than the cost of the best position of the particle
        % then the best position of the particle is the current position
        if particle(i).Cost < particle(i).Best.Cost
            
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;
            
            % Update Global Best
            % if the cost of the current position is less than the cost of the best position of the swarm
            % then the best position of the swarm is the current position
            if particle(i).Best.Cost < GlobalBest.Cost
                GlobalBest = particle(i).Best;
            end
            
        end
        
    end
    
    % Store the Best Cost Value
    BestCosts(it) = GlobalBest.Cost;
    
    % if the best cost value is less than the tolerance and the flag is not set
    % this is reffered to as the minimum tolerance for the cost value
    if abs(BestCosts(it)) < params.tol && TolMinFlag == false
        disp(['Lower than tolerance: ', num2str(it)]);
        TolMin = it;
        TolMinFlag = true;
    end
    
    % Display Iteration Information
    % Display Iteration Information (if ShowIterInfo is True)
    if ShowIterInfo
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
    end
    
    % Damping Inertia Coefficient
    inertiaCoefficient = inertiaCoefficient * wdamp;
    
    if pausing
        clf;
        Plot;
        pause;
    end
    
end

out.pop = particle;
out.BestSol = GlobalBest;
out.BestCosts = BestCosts;
out.TolMin = TolMin;

if showContourPlot
    Plot
    pause(0.05)
end

end