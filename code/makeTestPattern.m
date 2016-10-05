function [compareA, compareB] = makeTestPattern(patchWidth, nbits)  
% input
% patchWidth - the width of the image patch (usually 9)
% nbits - the number of tests n in the BRIEF descriptor
% output
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors. 
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.
s = 1:9;
lind = sub2ind([patchWidth patchWidth],s,s)';
% compareA = randsample(lind,nbits,'true');
% compareB = randsample(lind,nbits,'true');
% compareA = randi([1 patchWidth*patchWidth],1,nbits)';
% compareB = randi([1 patchWidth*patchWidth],1,nbits)';
% indxA = [];
% indyA = [];
% indxB = [];
% indyB = [];
% 
% for i = 1:29
%     indxAi = normrnd(0,9/5,[1 patchWidth]);
%     indxAi = round(indxAi/norm(indxAi)*4 + 5);
%     indyAi = normrnd(0,9/5,[1 patchWidth]);
%     indyAi = round(indyAi/norm(indyAi)*4 + 5);
%     indxBi = normrnd(0,9/5,[1 patchWidth]);
%     indxBi = round(indxBi/norm(indxBi)*4 + 5);
%     indyBi = normrnd(0,9/5,[1 patchWidth]);
%     indyBi = round(indyBi/norm(indyBi)*4 + 5);
%     
%     indxA = [indxA indxAi];
%     indyA = [indyA indyAi];
%     indxB = [indxB indxBi];
%     indyB = [indyB indyBi];
% end
% indxA = indxA(1:256);
% indyA = indyA(1:256);
% indxB = indxB(1:256);
% indyB = indyB(1:256);
% indxA = repmat(indxA,patchWidth,1);
% indxA = indxA(:)';
% indyA = repmat(indyA,1,patchWidth);
% indxB = repmat(indxB,patchWidth,1);
% indxB = indxB(:)';
% indyB = repmat(indyB,1,patchWidth);

mu = [0,0];
sigma = [81/5,0;0,81/5];
rng shuffle  % For reproducibility
rA = mvnrnd(mu,sigma,256);
size(rA)
compareA = round(rA(:,1)/norm(rA(:,1))*41+41)';
compareB = round(rA(:,2)/norm(rA(:,2))*41+41)';
% 
% rB = mvnrnd(mu,sigma,256);
% rB(:,1) = round(rB(:,1)/norm(rB(:,1))*4+5);
% rB(:,2) = round(rB(:,2)/norm(rB(:,2))*4+5);
% 
% compareA = sub2ind([patchWidth patchWidth],rA(:,1),rA(:,2))';
% compareB = sub2ind([patchWidth patchWidth],rB(:,1),rB(:,2))';