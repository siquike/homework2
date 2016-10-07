function H2to1 = computeH(p1,p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
n = size(p1,2);
p1h = [p1;ones(1,n)]';
left = [p1h(:) zeros(size(p1h(:),1),1)]';
left = reshape(left,[],3);
pint = [left(end,:);left(1:end-1,:)];
left = [left pint]
first = [-p2(1,:)'.*p1(1,:)' -p2(1,:)'.*p1(2,:)' -p1(1,:)']';
first = first(:);
second = [-p2(2,:)'.*p1(1,:)' -p2(2,:)'.*p1(2,:)' -p2(2,:)']';
second = second(:);
third = [first second]';
s = repmat(3,1,size(third,2)/3);
C = mat2cell(third,2,s);
C = C(:);
third = cell2mat(C)
eq = [left third];
[U,S,V] = svd(eq);
H2to1 = V';
H2to1 = H2to1(:,end);
H2to1 = reshape(H2to1,3,[]);
H2to1 = inv(H2to1);