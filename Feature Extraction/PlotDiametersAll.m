function PlotDiametersAll( filename ) 

[I, boundary] = BoundaryTracing(filename);

for n = 0:359 
    i_rotate = imrotate(I,n,'bilinear','loose');
    centroids = findCentroids(I);
    [y1(n+1),y2(n+1)] = findDiameter(i_rotate,centroids);
end 

plotDiameters(y1,y2);

end 