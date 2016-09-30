%% 1.1

im = imread('chickenbroth_01.jpg');
sigma0 =1;
k = sqrt(2);
levels = [-1 0 1 2 3 4];

[GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);

vGaussianPyr = figure
displayPyramid(GaussianPyramid);

%% 1.2

[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);

vDoGPyr = figure
displayPyramid(DoGPyramid);

%% 1.3

PrincipalCurvature = computePrincipalCurvature(DoGPyramid)

thetac = 0.03;