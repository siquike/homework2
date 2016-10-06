function H2to1 = computeH(p1,p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
p1 = [p1;ones(1,size(p1,2))]
p2 = [p2;ones(1,size(p2,2))]
H2to1 = p1.\p2';