function [] = PlotDiameters( y1, y2 )
    figure;
    dist = abs(y1-y2);
    x = 1:360;
    figure; plot(x, dist); 
    axis tight; xlabel('Angle'); ylabel('Diameter (Pixels)');
end

