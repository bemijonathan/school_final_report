function medianBenchmark = BenchMark(problem, params, properties)

    numberOfIterations = 10;
    
    % destructuring  properties
    titleText = properties.titleText;
    medianBenchmark = zeros(1, numberOfIterations);
    legendInfo = cell(1, numberOfIterations);
    
    figure;
    hold on;
    grid on;
    xlabel('Iterations');
    ylabel('Best Cost');
    title(titleText);
    
    % Prepare to store minimum Y values
    minYValues = zeros(1, numberOfIterations);
    
    for i = 1:numberOfIterations
        if isfield(properties, "operatorType") && ~isempty(properties.operatorType)
            operatorType = properties.operatorType;
            operatorValue = properties.operatorValue;
            params.(operatorType) = operatorValue;  % Set the operator type and value
        end
        out = BestTwoBin(problem, params);
        
        BestCost = out.BestCost;
        
        %% Plot results for current iteration
        semilogx(BestCost, 'LineWidth', 2);
        hold on; % Keep the plot
        
        % Capture the minimum Y value for the iteration
        minYValues(i) = min(BestCost);
        
        xlabel('Iteration');
        ylabel('Best Cost');
        grid on;
        medianBenchmark(i) = out.TolMin;
        legendInfo{i} = ['Trial - ' num2str(i) ' : ' num2str(out.TolMin)];
    end
        
        % Calculate the median of the benchmark
        median_x = round(median(medianBenchmark));
        minY = min(minYValues); % Minimum Y value across all iterations
        
        % Plot median marker at the minimum Y of all plotted data
        semilogx(median_x, minY, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
        legendInfo{end+1} = ['Median after ' num2str(numberOfIterations) ' iterations: ' num2str(median_x)];
        legend(legendInfo);
        hold off;
end