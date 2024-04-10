function PlotGAParameterEffects(paramName, paramRange, SPOattributes , subplotIndex)

problem = SPOattributes.problem;
params = SPOattributes.params;

contourSubPlotIndex = 1;

if ~params.showContourPlot
    subplot(3, 2, subplotIndex); % Arrange line plots in a 2x3 grid
end

for i = 1:length(paramRange)
    
    params.(paramName) = paramRange(i);
    params.paramName = paramName;
    
    disp(string(paramRange(i)))
    disp(paramName)

    params.contourSubPlotIndex = contourSubPlotIndex;
    contourSubPlotIndex = contourSubPlotIndex + 1;
    
    out = RunGA(problem, params);
    
    if ~params.showContourPlot
        semilogx(out.bestcost, 'LineWidth', 2);
        hold on;
    end
    
end
if ~params.showContourPlot
    xlabel('Iterations');
    ylabel('Best Cost');
    title(['Effect of ', paramName, ' on Best Cost']);
    legendInfo = strsplit(num2str(paramRange));
    legend(legendInfo, 'Location', 'northeastoutside');
    hold off;
end
disp('___')
end