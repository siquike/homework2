%% 1.1

im = imread('model_chickenbroth.jpg');
%%
% figure; imagesc(DoGPyramid(:,:,5))
%%

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

PrincipalCurvature = computePrincipalCurvature(DoGPyramid);

% Test = PrincipalCurvature;
% figure
% imagesc(Test(:,:,5))
% hold on
% displayPyramid(DoGPyramid);



thetac = 0.03;

%% Test
points = DoGPyramid;

points(abs(PrincipalCurvature) > 12) = nan;
figure;displayPyramid(points)

%%

DoGlocs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,.03, 12);
figure;displayPyramid(DoGlocs)


%% 1.5
im = imread('model_chickenbroth.jpg');

sigma0 =1;
k = sqrt(2);
levels = [-1 0 1 2 3 4];
th_contrast = 0.03;
th_r = 12;

[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels,th_contrast, th_r);

%%
figure; hold on; imagesc(im);scatter(locsDoG(:,1),locsDoG(:,2),'.')

%%

[compareA, compareB] = makeTestPattern(9, 256);
%%
[locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB);

%%
im1 = imread('model_chickenbroth.jpg');
[locs1, desc1] = briefLite(im1);

im2 = imread('chickenbroth_01.jpg');
[locs2, desc2] = briefLite(im2);
%%

[matches] = briefMatch(desc1, desc1,10);

%%

plotMatches(im1, im1, matches, locs1, locs1)
