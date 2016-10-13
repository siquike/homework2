function im3 = generatePanorama(im1,im2)
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2,0.3);
% [bestH] = ransacH(matches, locs1, locs2, 20000, 1);
% [im3] = imageStitching_noClip(im1, im2, bestH);
match1 = locs1(matches(:,1),1:2);
match2 = locs2(matches(:,2),1:2);
H2to1 = computeH(match1',match2');
[im3] = imageStitching(im1, im2, H2to1);
end
