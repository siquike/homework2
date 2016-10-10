function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB)
%%Compute Brief feature
% input
% im - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column is 
%		 the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of valid descriptors in the image and will vary
desc = nan(size(locsDoG,1),256);
locs = nan(size(locsDoG,1),3);
count = 0;

for i = 1:size(locsDoG,1)
        locx = locsDoG(i,1)-4:locsDoG(i,1)+4;
        locy = locsDoG(i,2)-4:locsDoG(i,2)+4;
        locz = locsDoG(i,3);
        if((sum(locx > 0) == 9 )&& (sum(locy > 0) == 9) && (sum(locx <= size(GaussianPyramid,1)) == 9) && (sum(locy <= size(GaussianPyramid,2)) == 9))
            count = count +1;
            p = GaussianPyramid(locx,locy,locz);
            desc(count,:) = (p(compareA) < p(compareB))';
            locs(count,:) = locsDoG(i,:);
        end
end

desc = desc(any(desc,2),:);
locs = locs(any(locs,2),:);
locs = [locs(:,2) locs(:,1) locs(:,3)];
