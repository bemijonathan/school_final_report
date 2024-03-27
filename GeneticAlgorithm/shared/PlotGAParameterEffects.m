function PlotGAParameterEffects(paramName, paramRange, problem, params, subplotIndex)
subplot(3, 2, subplotIndex); % Arrange plots in a 2x3 grid
for i = 1:length(paramRange)
    params.(paramName) = paramRange(i);
    out = RunGA(problem, params);
    semilogx(out.bestcost, 'LineWidth', 2);
    hold on;
end
xlabel('Iterations');
ylabel('Best Cost');
title(['Effect of ', paramName, ' on Best Cost']);
legendInfo = strsplit(num2str(paramRange));
legend(legendInfo, 'Location', 'northeastoutside');
hold off;
end

