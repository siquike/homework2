function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.
img1 = cat(2,img1, zeros(size(img1,1),1000,size(img1,3)));
M = [0.5  0    1;
     0    0.5  100;
     0    0    1];
warp_im1 = warpH(img1, M, [500 900],0);
warp_im2 = warpH(img2, M*H2to1, [500 900],0);
panoImg = bsxfun(@max,warp_im1,warp_im2);
imwrite(panoImg,'q5_2_pan.jpg')
