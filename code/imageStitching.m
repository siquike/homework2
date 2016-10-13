function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
img1 = cat(2,img1, zeros(size(img1,1),1000,size(img1,3)));
warp_im = warpH(img2, H2to1, [size(img1,1) size(img1,2)],0);
panoImg = bsxfun(@max,warp_im,img1);
save('q5_1.mat','H2to1')
imwrite(panoImg,'q5_1.jpg')
