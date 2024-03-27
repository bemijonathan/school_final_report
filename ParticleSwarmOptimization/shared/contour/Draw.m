% Clear Figure
hold on

% Prepare Mesh for Contour Plots
x1 = linspace(VarMin,VarMax);
x2 = linspace(VarMin,VarMax);
[X1,X2] = meshgrid(x1,x2);

% Contour Plot of Cost Function
Z = CostFunction(X1,X2);
colormap(bone)
contour(X1, X2, log(Z), 5);

% Plot whole Population as red stars
for i = 1:nPop
    plot(pop(i).Position(1), pop(i).Position(2), 'r*')
end

axis equal