function g = InequalityConstraints(x1, x2, R)
    % Constraints g(x1, x2) >= 0
    g(:,:,1) = 26 - (x1 - 5).^2 - x2.^2;
    g(:,:,2) = 20 - 4*x1 - x2;

    % If Constraint satisfied, then make it 0
    g(g > 0) = 0;
    
    % Penalty = Σ R*|{g(u1,u2)}|
    g = sum(R.*abs(g),3);
    
    % Remove extra dimensi`     ons
    g = squeeze(g);
end