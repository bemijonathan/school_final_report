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

for i = 1:numberOfIterations
    if isfield(properties, "operatorType") && ~isempty(properties.operatorType)
        operatorType = properties.operatorType;
        operatorValue = properties.operatorValue;
        params.(operatorType) = operatorValue;  % Set the operator type and value
    end
    out = RandOneBin(problem, params);
    
    BestCost = out.BestCost;
    
    %% Results
    
    semilogx(BestCost, 'LineWidth', 2);
    xlabel('Iteration');
    ylabel('Best Cost');
    grid on;
    medianBenchmark(i) = out.TolMin;
    legendInfo{i} = ['Trial - ' num2str(i) ' : ' num2str(out.TolMin)];
end

% Calculate the median of the benchmark
median_x = round(median(medianBenchmark));
semilogx(median_x, min(ylim), 'ro', 'MarkerSize', numberOfIterations, 'LineWidth', 2);
legendInfo{(numberOfIterations + 1)} = ['Median after 5 iterations: ' num2str(median_x)];
legend(legendInfo);
hold off;
end