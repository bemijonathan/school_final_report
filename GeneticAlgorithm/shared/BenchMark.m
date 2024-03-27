function medianBenchmark = BenchMark(problem, params, properties)

titleText = properties.titleText;
medianBenchmark = zeros(1, 10);
legendInfo = cell(1, 10);

figure;
hold on;
grid on;
xlabel('Iterations');
ylabel('Best Cost');
title(titleText);

for i = 1:10
    if isfield(properties, "operatorType") && ~isempty(properties.operatorType)
        operatorType = properties.operatorType;
        operatorValue = properties.operatorValue;
        params.(operatorType) = operatorValue;  % Set the operator type and value
    end
    out = RunGA(problem, params);
    
    medianBenchmark(i) = out.lastBestCostIterationIndex;
    semilogy(out.bestcost, 'LineWidth', 2);
    legendInfo{i} = ['Trial - ' num2str(i) ' : ' num2str(out.lastBestCostIterationIndex)];
end

% Calculate the median of the benchmark
median_x = round(median(medianBenchmark));
plot(median_x, min(ylim), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
legendInfo{11} = ['Median after 10 iterations: ' num2str(median_x)];
legend(legendInfo);
hold off;
end