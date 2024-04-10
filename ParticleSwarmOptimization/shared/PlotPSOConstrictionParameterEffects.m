function PlotPSOConstrictionParameterEffects(paramName, paramRange, SPOattributes , subplotIndex)

problem = SPOattributes.problem;
params = setUpConstrictionCoefficients(SPOattributes.params);
population = SPOattributes.population;

contourSubPlotIndex = 1;

if ~params.showContourPlot
    subplot(3, 2, subplotIndex); % Arrange line plots in a 2x3 grid
end

for i = 1:length(paramRange)
    
    params.(paramName) = paramRange(i);
    params.paramName = paramName;
    
    disp(string(paramRange(i)))
    disp(paramName)
    
    if paramName == "populationSize"
        population = InitializePopulation(problem, params);
    end
    
    params.contourSubPlotIndex = contourSubPlotIndex;
    contourSubPlotIndex = contourSubPlotIndex + 1;
    
    out = PSO(problem, params, population);
    
    if ~params.showContourPlot
        semilogx(out.BestCosts, 'LineWidth', 2);
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


function cc = setUpConstrictionCoefficients(params)
% Define Constriction Coefficients
% Initialize kappa, a constant used in the calculation of constriction coefficient.
kappa = 1;

% phi1 and phi2 represent cognitive and social coefficients respectively.
phi1 = 2.05;
phi2 = 2.05;

% Calculate the sum of cognitive and social coefficients.
phi = phi1 + phi2;

% Compute the constriction coefficient chi using Clerc and Kennedy's formula.
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));
cc = params;
% Assign the calculated constriction coefficient chi to the inertiaCoefficient.
cc.inertiaCoefficient = chi; % Intertia Coefficient from Constriction Coefficients

% Calculate and assign personal acceleration coefficient,
% scaled by constriction coefficient chi.
cc.personalAccCoefficient = chi*phi1; % Personal Acceleration Coefficient from Constriction Coefficients

% Calculate and assign social acceleration coefficient,
% scaled by constriction coefficient chi.
cc.socialAccCoefficient = chi*phi2; % Social Acceleration Coefficient from Constriction Coefficients
end



