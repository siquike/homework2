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
nnum1 = nan(1,256);
nnum2 = nan(1,3);

desc = nan(size(locsDoG,1),256);
locs = nan(size(locsDoG,1),3);

for i = 1:size(locsDoG,1)
    try
        locx = locsDoG(i,1)-4:locsDoG(i,1)+4;
        locy = locsDoG(i,2)-4:locsDoG(i,2)+4;
        locz = locsDoG(i,3);
        p = GaussianPyramid(locx,locy,locz);
        desc(i,:) = (p(compareA) < p(compareB))';
        locs(i,:) = locsDoG(i,:);
    catch
        desc(i,:) = nnum1;
        locs(i,:) = nnum2;
    end
end

desc = desc
locs = locs;

desc = desc(any(desc,2),:)
locs = locs(any(locs,2),:);
% desc = reshape(desc,[],256);
% locs = reshape(desc,[],3);

%%


% for i = 1:size(locsDoG,1)
%     locx = locsDoG(i,1)-4:locsDoG(i,1)+4
%     locy = locsDoG(i,2)-4:locsDoG(i,2)+4
%     locz = locsDoG(i,3);
%     if(((sum(locx <= 0)) == 0) && ((sum(locy <= 0)) == 0) && ((sum(locx > size(im,2))) == 0) && ((sum(locy > size(im,1))) == 0))
%         patch = GaussianPyramid(locx,locy,locz);
%         patch = patch(:);
% %         patch(compareA)
% %         patch(compareB)
%         desc(i,:) = (patch(compareA) < patch(compareB))';
%         locs(i,:) = locsDoG(i,:);
%     else
%         desc(i,:) = nnum1;
%         locs(i,:) = nnum2;
%     end
% end
% 
% desc = desc(~isnan(desc));
% locs = locs(~isnan(locs));