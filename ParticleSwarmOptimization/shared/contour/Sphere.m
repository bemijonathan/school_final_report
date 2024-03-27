function f = Sphere(x1, x2)

% f = x1.^2 + x2.^2;
% Rosenbrock
f = 100*(x2 - x1.^2).^2 + (1 - x1).^2;
