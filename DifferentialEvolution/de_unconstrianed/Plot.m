% Clear Figure
hold on

% Prepare Mesh for Contour Plots
x1 = linspace(VarMin,VarMax);
x2 = linspace(VarMin,VarMax);
[X1,X2] = meshgrid(x1,x2);

% Contour Plot of Cost Function
Z = Himmelblau(X1,X2);
colormap(jet)
contour(X1, X2, log(Z), 5);
xlabel('x1')
ylabel('x2')
title('Himmelblau Function Contour Plot on Iteration ' + string(it) + ' of ' + string(MaxIt))

% Plot Best Particle as blue star
plot(BestSol.Position(1), BestSol.Position(2), 'b*', 'MarkerSize', 10, 'MarkerFaceColor', 'b')
% Plot whole Population as thick red stars
for i = 1:nPop
    plot(pop(i).Position(1), pop(i).Position(2), 'r*', 'MarkerSize', 10)
end

% add color gradient to background of contour plot
h = colorbar;
ylabel(h, 'log(Cost Function Value)')
% Set
axis([VarMin VarMax VarMin VarMax])

axis tight