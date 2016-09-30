function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each point contains the curvature ratio R for the 
% 					   corresponding point in the DoG pyramid
thetar = 12;
nx = size(DoGPyramid,1);
ny = size(DoGPyramid,2);
nz = size(DoGPyramid,3);
PrincipalCurvature = nan(nx*ny,nz);


for i = nz
    [Dx,Dy] = gradient(DoGPyramid(:,:,i));
    [Dxx,Dxy] = gradient(Dx);
    [Dyx,Dyy] = gradient(Dy);
    
    hessians = Dxx;
    hessians(:,:,2) = Dyx;
    hessians(:,:,3) = Dxy;
    hessians(:,:,4) = Dyy;
    
    hessians = permute(hessians,[3 1 2]);
    hessians = reshape(hessians,2,[],1);
    hessians = reshape(hessians,2,2,[]);
    
    for j= 1:nx*ny
        H = hessians(:,:,j);
        PrincipalCurvature(j,i) = trace(H)/det(H);
    end
end

PrincipalCurvature = reshape(PrincipalCurvature,nx,ny,nz);
% PrincipalCurvature = PrincipalCurvature(PrincipalCurvature > thetar);
 