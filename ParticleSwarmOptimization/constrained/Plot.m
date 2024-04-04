% Clear Figure
hold on

% Prepare Mesh for Contour Plots
x1 = linspace(decisionVarLowerBound(1),decisionVarUpperBound(1));
x2 = linspace(decisionVarLowerBound(end),decisionVarUpperBound(end));
[X1,X2] = meshgrid(x1,x2);


C = problem.Constraints(X1, X2, R);
contourf(X1, X2, C, [eps eps], 'b');


% Contour Plot of Cost Function
Z = Himmelblau(X1,X2);
colormap(jet)
contour(X1, X2, log(Z), 5);
xlabel('x1')
ylabel('x2')
title('Rosenbrock Function Contour Plot on Iteration ' + string(it) + ' of ' + string(MaxIt))

% Plot Best Particle as blue star
% plot(GlobalBest.Position(1), GlobalBest.Position(2), 'b*', 'MarkerSize', 10, 'MarkerFaceColor', 'b')
% Plot whole Population as thick red stars
for i = 1:populationSize
    plot(particle(i).Position(1), particle(i).Position(2), 'r*', 'MarkerSize', 10)
end

% add color gradient to background of contour plot
h = colorbar;
ylabel(h, 'log(Cost Function Value)')
% Set
% axis([decisionVarLowerBound decisionVarUpperBound decisionVarLowerBound decisionVarUpperBound])

axis equal