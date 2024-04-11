function a = savePlot (name)
    set(gcf, 'Units', 'normalized', 'Position', [0 0 1 1]);
    pause(5);
    saveas(gcf, name);
end