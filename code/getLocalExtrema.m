function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)
%%Detecting Extrema
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a DoG response magnitude above this threshold
% th_r - remove any edge-like points that have too large a principal curvature ratio
% output
% locs - N x 3 matrix where the DoG pyramid achieves a local extrema in both scale and space, and also satisfies the two thresholds.
dim = size(DoGPyramid);

DoGPyramid(abs(DoGPyramid) < th_contrast) = nan;
DoGPyramid(abs(PrincipalCurvature) > th_r) = nan;
DoGPyramid = DoGPyramid(:);
[y,x,z] = ind2sub(dim,find(~isnan(DoGPyramid)));
locs = [x y z];