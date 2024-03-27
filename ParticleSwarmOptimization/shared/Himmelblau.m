function z = Himmelblau(x, y)
%  the general formular of Rosenbrock function is
% f(x) = sum((x.^2 + y - 11).^2 + (x + y.^2 - 7).^2)
% where x = the current vector
% y = the next vector in the vector x
z = (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
end

