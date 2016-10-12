function [ centroids ] = FindCentroids( I )
    stats = regionprops(I);
    maxArea = 0;
    for i = 1:length(stats)
        if (maxArea <= stats(i).Area)
            maxArea = max(stats(i).Area);
            handle = i;
        end
    end
    centroids = stats(handle).Centroid;
end

