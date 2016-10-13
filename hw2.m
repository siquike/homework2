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

%%

locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,.03, 12);
figure;imagesc(im);hold on
plot(locsDoG(:,2),locsDoG(:,1),'r+')


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
figure;imagesc(im);hold on
plot(locsDoG(:,2),locsDoG(:,1),'r+')

%%

[compareA, compareB] = makeTestPattern(9, 256);
%%
[locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB);

%% 2.4
im1 = im2double(imread('model_chickenbroth.jpg'));
[locs1, desc1] = briefLite(im1);

im2 = im2double(imread('chickenbroth_01.jpg'));
[locs2, desc2] = briefLite(im2);
%%

[matches] = briefMatch(desc1, desc2,0.5);

%%
fig = figure
plotMatches(im1, im2, matches, locs1, locs2)

%% 2.5

im1 = im2double(imread('model_chickenbroth.jpg'));
[locs1, desc1] = briefLite(im1);

im2 = im2double(imread('chickenbroth_01.jpg'));
im2 = imrotate(im2,60);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2,0.5);
chik = figure
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
p1 = [1 1 2 2;1 2 1 2];
p2 = [1 1 3 3;1 3 1 3];
H2to1 = computeH(p1,p2)

p1H = H2to1*[p2; 1 1 1 1]

%% Q5
img1 = im2double(imread('incline_L.png'));
img2 = im2double(imread('incline_R.png'));

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2,.3);
%%
fig2 = figure
plotMatches(img1, img2, matches, locs1, locs2)

%%

img1 = im2double(imread('pf_scan_scaled.jpg'));
img2 = im2double(imread('pf_pile.jpg'));
if(size(img1,3) < 3)
 img1 = repmat(img1,1,1,3);
end
if(size(img2,3) < 3)
 img2 = repmat(img2,1,1,3);
end

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2,.5);
pf1 = figure
plotMatches(img1, img2, matches, locs1, locs2)

%%

img1 = im2double(imread('pf_scan_scaled.jpg'));
img2 = im2double(imread('pf_stand.jpg'));
if(size(img1,3) < 3)
 img1 = repmat(img1,1,1,3);
end
if(size(img2,3) < 3)
 img2 = repmat(img2,1,1,3);
end

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2,.3);
pf2 = figure
plotMatches(img1, img2, matches, locs1, locs2)

%%

img1 = im2double(imread('pf_scan_scaled.jpg'));
img2 = im2double(imread('pf_desk.jpg'));
if(size(img1,3) < 3)
 img1 = repmat(img1,1,1,3);
end
if(size(img2,3) < 3)
 img2 = repmat(img2,1,1,3);
end

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2,.3);
pf3 = figure
plotMatches(img1, img2, matches, locs1, locs2)

%%

img1 = im2double(imread('pf_scan_scaled.jpg'));
img2 = im2double(imread('pf_floor.jpg'));
if(size(img1,3) < 3)
 img1 = repmat(img1,1,1,3);
end
if(size(img2,3) < 3)
 img2 = repmat(img2,1,1,3);
end

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2,.3);
pf4 = figure
plotMatches(img1, img2, matches, locs1, locs2)

%%

img1 = im2double(imread('pf_scan_scaled.jpg'));
img2 = im2double(imread('pf_floor_rot.jpg'));
if(size(img1,3) < 3)
 img1 = repmat(img1,1,1,3);
end
if(size(img2,3) < 3)
 img2 = repmat(img2,1,1,3);
end

[locs1, desc1] = briefLite(img1);
[locs2, desc2] = briefLite(img2);
[matches] = briefMatch(desc1, desc2,.3);
pf5 = figure
plotMatches(img1, img2, matches, locs1, locs2)
%%
match1 = locs1(matches(:,1),1:2);
match2 = locs2(matches(:,2),1:2);
% H2to1 = computeH(match1',match2');
[bestH] = ransacH(matches, locs1, locs2, 40000, 1);
%%
[panoImg] = imageStitching(img1, img2, bestH);

figure;imagesc(img1);
%%
hold on; imagesc(img1)

%%
hold on; imshow(img_masked)

%%

[panoImg] = imageStitching_noClip(img1, img2, bestH);
%%
[panoImg] = imageStitching_noClip(img1, img2, H2to1)

%% Generate Panorama
im1 = im2double(imread('incline_L.png'));
im2 = im2double(imread('incline_R.png'));
im3 = generatePanorama(im1,im2);

fig3 = figure

imagesc(im3)
