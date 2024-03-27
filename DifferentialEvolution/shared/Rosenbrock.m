function z = Rosenbrock(x1, x2)
%  the general formular of Rosenbrock function is
% f(x) = sum(100*( b - a^2 )^2 + (1 - a)^2)
% where a = the current vector
% b = the next vector in the vector x
z = 100*(x2 - x1.^2).^2 + (1 - x1).^2;
end

