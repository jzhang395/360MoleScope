function [ segmented_images ] = ClusterMole(img, nColors )
    img_lab = rgb2lab(img);
    ab = double(img_lab(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    [cluster_idx, cluster_center] = kmeans(ab,nColors,...
                                    'distance','sqEuclidean',...
                                    'Replicates', 3);

    pixel_labels = reshape(cluster_idx, nrows, ncols);
    segmented_images = cell(1,3);
    rgb_label = repmat(pixel_labels,[1 1 3]);
    for k = 1:nColors
        color = img;
        color(rgb_label ~= k) = 0;
        segmented_images{k} = color;
    end
end

