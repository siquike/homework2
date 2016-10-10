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
% DoGPyramid = cat(3,DoGPyramid(:,:,1),DoGPyramid);
% DoGPyramid = cat(3,DoGPyramid,DoGPyramid(:,:,end));
dim = size(DoGPyramid);
locs = nan(dim(1),dim(2),dim(3));

for k = 1:dim(3)
    for j = 2:dim(2)-1
        for i = 2:dim(1)-1
            if(k == 1)
                neighbours = [DoGPyramid(i-1,j-1,k) DoGPyramid(i+1,j+1,k) DoGPyramid(i-1,j,k) DoGPyramid(i,j-1,k)...
                              DoGPyramid(i-1,j+1,k) DoGPyramid(i+1,j-1,k) DoGPyramid(i,j+1,k) DoGPyramid(i+1,j,k)...
                              DoGPyramid(i,j,k+1)];
                if((sum(DoGPyramid(i,j,k) > neighbours) == 9) || (sum(DoGPyramid(i,j,k) < neighbours) == 9))
                    locs(i,j,k) = DoGPyramid(i,j,k);
                else
                    locs(i,j,k) = nan;
                end
            elseif(k == dim(3))
                neighbours = [DoGPyramid(i-1,j-1,k) DoGPyramid(i+1,j+1,k) DoGPyramid(i-1,j,k) DoGPyramid(i,j-1,k)...
                              DoGPyramid(i-1,j+1,k) DoGPyramid(i+1,j-1,k) DoGPyramid(i,j+1,k) DoGPyramid(i+1,j,k)...
                              DoGPyramid(i,j,k-1)];
                if((sum(DoGPyramid(i,j,k) > neighbours) == 9) || (sum(DoGPyramid(i,j,k) < neighbours) == 9))
                    locs(i,j,k) = DoGPyramid(i,j,k);
                else
                    locs(i,j,k) = nan;
                end
            else
                neighbours = [DoGPyramid(i-1,j-1,k) DoGPyramid(i+1,j+1,k) DoGPyramid(i-1,j,k) DoGPyramid(i,j-1,k)...
                              DoGPyramid(i-1,j+1,k) DoGPyramid(i+1,j-1,k) DoGPyramid(i,j+1,k) DoGPyramid(i+1,j,k)...
                              DoGPyramid(i,j,k-1) DoGPyramid(i,j,k+1)];
                if((sum(DoGPyramid(i,j,k) > neighbours) == 10) || (sum(DoGPyramid(i,j,k) < neighbours) == 10))
                    locs(i,j,k) = DoGPyramid(i,j,k);
                else
                    locs(i,j,k) = nan;
                end
            end
        end
    end
end

locs(abs(locs) < th_contrast) = nan;
locs(abs(PrincipalCurvature) > th_r) = nan;
locs = locs(:);
[x,y,z] = ind2sub(dim,find(~isnan(locs)));
locs = [x y z];


%%
% dim = size(DoGPyramid);
% for i = 2:dim-1
%     DoGPyramid(abs(DoGPyramid) <= th_contrast) = nan;
%     DoGPyramid(abs(PrincipalCurvature) > th_r) = nan;
% end
% 
% DoGPyramid = DoGPyramid(:);
% [y,x,z] = ind2sub(dim,find(~isnan(DoGPyramid)));
% locs = [x y z];