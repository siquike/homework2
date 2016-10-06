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
figure;imagesc(im);hold on
plot(DoGlocs(:,1),DoGlocs(:,2),'+')


%% 1.5
im = imread('model_chickenbroth.jpg');
% im = imread('chickenbroth_01.jpg');

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

%% 2.4
im1 = rgb2gray(im2double(imread('model_chickenbroth.jpg')));
[locs1, desc1] = briefLite(im1);

im2 = rgb2gray(im2double(imread('chickenbroth_01.jpg')));
[locs2, desc2] = briefLite(im2);
%%

[matches] = briefMatch(desc1, desc2,.8);

%%

plotMatches(im1, im2, matches, locs1, locs2)

%% 2.5

im1 = rgb2gray(im2double(imread('model_chickenbroth.jpg')));
[locs1, desc1] = briefLite(im1);

im2 = rgb2gray(im2double(imread('model_chickenbroth.jpg')));
im2 = imrotate(im2,0);
[locs2, desc2] = briefLite(im2);
%%

[matches] = briefMatch(desc1, desc2);

%%
figure
plotMatches(im1, im2, matches, locs1, locs2)


%%

mu = [0,0];
sigma = [9/5,0;0,9/5];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,256);
r(:,1) = round(r(:,1)/norm(r(:,1))*41+41);
r(:,2) = round(r(:,2)/norm(r(:,2))*41+41);

figure
plot(r(:,1),r(:,2),'+')
%%
mu = [0,0];
sigma = [9/5,0;0,9/5];
rng shuffle  % For reproducibility

v1 = sum(rand(9,256) > 0.5)+1
v2 = sum(rand(9,256) > 0.5)+1

figure
plot(v1,v2,'+')

%% homography
p1 = [1 2 3;1 2 3];
p2 = [5 2 5;5 6 7];
H2to1 = computeH(p1,p2)