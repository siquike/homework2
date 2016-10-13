for i = 1:36
    im1 = im2double(imread('model_chickenbroth.jpg'));
    [locs1, desc1] = briefLite(im1);

    im2 = im2double(imread('model_chickenbroth.jpg'));
    im2 = imrotate(im2,i*10);
    [locs2, desc2] = briefLite(im2);
    [matches] = briefMatch(desc1, desc2,0.8);
    nmatches(i) = size(matches,1);
end
%%
figure
% nmatches
angle = 10:10:360;
barh(angle,nmatches)