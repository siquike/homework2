function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
warp_im = warpH(img2, H2to1, [1000 1000],0);
figure;hold on; imwrite(warp_im);
% imagesc(img1)
panoImg = warp_im;