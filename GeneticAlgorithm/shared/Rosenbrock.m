function e = Rosenbrock (x, y)
    e = 100*(y - x.^2).^2 + (1 - x).^2;
end