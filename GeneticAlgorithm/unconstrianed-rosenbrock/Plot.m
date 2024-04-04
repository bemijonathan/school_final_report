% Clear Figure
hold on

decisionVarLowerBound = problem.VarMin;
decisionVarUpperBound = problem.VarMax;

% Prepare Mesh for Contour Plots
x1 = linspace(decisionVarLowerBound,decisionVarUpperBound);
x2 = linspace(decisionVarLowerBound,decisionVarUpperBound);
[X1,X2] = meshgrid(x1,x2);



% Contour Plot of Cost Function
Z = Rosenbrock(X1, X2);


colormap(jet)
contour(X1, X2, Z);
xlabel('x1')
ylabel('x2')
title('Rosenbrock Function Contour Plot on Iteration ' + string(it) + ' of ' + string(maximumIteration))

plot(bestsol.Position(1), bestsol.Position(2), 'bo', 'MarkerSize', 10)

% Plot whole Population as thick red stars
for i = 1:populationSize
    plot(pop(i).Position(1), pop(i).Position(2), 'r*', 'MarkerSize', 10)
end

% add color gradient to background of contour plot
h = colorbar;
ylabel(h, 'log(Cost Function Value)')
% Set
axis([decisionVarLowerBound decisionVarUpperBound decisionVarLowerBound decisionVarUpperBound])

axis tight