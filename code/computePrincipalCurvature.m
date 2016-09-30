function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each point contains the curvature ratio R for the 
% 					   corresponding point in the DoG pyramid
thetar = 12;


for i = 1:size(DoGPyramid,3)
    [Dx,Dy] = gradient(DoGPyramid(:,:,i));
    [Dxx,Dxy] = gradient(Dx);
    [Dyx,Dyy] = gradient(Dy);

    H = [Dxx Dxy;
         Dyx Dyy];
     
     size(Dxx)
     size(Dxy)
     size(Dyx)
     size(Dyy)
     
     size(H)
 
    PrincipalCurvature(:,:,i) = trace(H)/det(H);
end
 