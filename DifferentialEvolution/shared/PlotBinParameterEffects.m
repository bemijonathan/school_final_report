function PlotBinParameterEffects(paramName, paramRange, RandOneAttributes , subplotIndex)

    problem = RandOneAttributes.problem;
    params = RandOneAttributes.params;
   

    subplot(3, 2, subplotIndex); % Arrange plots in a 2x3 grid
   
   
    for i = 1:length(paramRange)
        out = RandOneBin(problem, params);
        params.(paramName) = paramRange(i);
        disp( string(paramRange(i)))
        plot(out.BestCost, 'LineWidth', 2);
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