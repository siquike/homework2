function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% input
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
% output
% bestH - homography model with the most inliers found during RANSAC
locs1s = [locs1(matches(:,1),1:2)'; ones(1,size(matches,1))]; 
locs2t = [locs2(matches(:,2),1:2)'; ones(1,size(matches,1))]; 

bestInNum = 0; % Best fitting line with largest number of inliers
bestH = computeH(locs1(matches(:,1),1:2)',locs2(matches(:,2),1:2)');
rng shuffle
for i = 1:nIter
    idx = randperm(size(matches,1),size(matches,1)/3);
    match1 = locs1(matches(idx,1),1:2)';
    match2 = locs2(matches(idx,2),1:2)';
    H2to1 = computeH(match1,match2);
    locs1t = H2to1*locs2t;
    inlierIdx = find(abs(locs1t-locs1s)<=tol);
    inlierNum = length(inlierIdx);

     if inlierNum>bestInNum
         bestInNum = inlierNum;
         bestH=H2to1;
     end
end