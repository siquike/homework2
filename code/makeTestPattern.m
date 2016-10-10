function [compareA, compareB] = makeTestPattern(patchWidth, nbits)  
% input
% patchWidth - the width of the image patch (usually 9)
% nbits - the number of tests n in the BRIEF descriptor
% output
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors. 
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.
rng default
% 
% s = 1:9;
% lind = sub2ind([patchWidth patchWidth],s,s)';
% 
% vA = sum(rand(80,10000) > 0.5)+1;
% vB = sum(rand(80,10000) > 0.5)+1;
% figure
% plot(vA,vB,'+')
% 
% compares = sub2ind([81 81],vA,vB)';
% [~,ia,~] = unique(compares);
% [I,J] = ind2sub([81 81],ia);
% I
% J
% compareA = vA(I);
% compareA = compareA(1:nbits);
% compareB = vB(J);
% compareB = compareB(1:nbits);
% 
% figure
% plot(compareA,compareB,'+')

compareA = randi(patchWidth.^2,nbits,1);
compareB = randi(patchWidth.^2,nbits,1);




% size(compareA)
% compareA = compareA(1:nbits);
% 
% compareB = sub2ind([patchWidth patchWidth],vB1,vB2)';
% compareB = unique(compareB);
% compareB = compareB(1:nbits);


% compareA = sub2ind([patchWidth patchWidth],rA(:,1),rA(:,2))';
% compareB = sub2ind([patchWidth patchWidth],rB(:,1),rB(:,2))';