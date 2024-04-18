% Clear Figure
if isfield(params, 'contourSubPlotIndex') 
    contourSubPlotIndex = params.contourSubPlotIndex;
    subplot(3, 2 , contourSubPlotIndex)
    hold on; 
else
    hold on
end 

decisionVarLowerBound = problem.VarMin;
decisionVarUpperBound = problem.VarMax;

% Prepare Mesh for Contour Plots
x1 = linspace(decisionVarLowerBound,decisionVarUpperBound);
x2 = linspace(decisionVarLowerBound,decisionVarUpperBound);
[X1,X2] = meshgrid(x1,x2);


% Contour Plot of Constraints (Shaded Region is Infeasible)
C = InequalityConstraints(X1, X2, params.R);
contourf(X1, X2, C, [eps eps], 'b');

% Contour Plot of Cost Function
Z = Himmelblau(X1,X2);
% colormap("parula")
contour(X1, X2, log(Z), 5);
xlabel('x1')
ylabel('x2')
title('Himmelblau Function Contour Plot on Iteration ' + string(it) + ' of ' + string(MaxIt))



% Plot whole Population as red stars
for i = 1:nPop
    plot(pop(i).Position(1), pop(i).Position(2), 'r*', 'MarkerSize', 10)
end
disp(BestSol)

% Plot Best Particle as blue star
plot(BestSol.Position(1), BestSol.Position(2), 'bo', 'MarkerSize', 20)
% add color gradient to background of contour plot
h = colorbar;
ylabel(h, 'log(Cost Function Value)')
% Set
axis([decisionVarLowerBound decisionVarUpperBound decisionVarLowerBound decisionVarUpperBound])

axis tight