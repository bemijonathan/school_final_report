function PlotPSOParameterEffects(paramName, paramRange, SPOattributes , subplotIndex)

 problem = SPOattributes.problem;
 params = SPOattributes.params;
 population = SPOattributes.population;

subplot(3, 2, subplotIndex); % Arrange plots in a 2x3 grid
for i = 1:length(paramRange)

    params.(paramName) = paramRange(i);

    disp( string(paramRange(i)))

    if paramName == "populationSize"
        population = InitializePopulation(problem, params);
    end

    out = PSO(problem, params, population);
    semilogx(out.BestCosts, 'LineWidth', 2);
    hold on;

end
xlabel('Iterations');
ylabel('Best Cost');
title(['Effect of ', paramName, ' on Best Cost']);
legendInfo = strsplit(num2str(paramRange));
legend(legendInfo, 'Location', 'northeastoutside');
hold off;
disp('___')
end