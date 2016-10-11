function H2to1 = computeH(p1,p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
n = size(p2,2);
p2h = [p2;ones(1,n)]';
left = [p2h(:) zeros(size(p2h(:),1),1)]';
left = reshape(left,[],3);
pint = [left(end,:);left(1:end-1,:)];
left = [left pint];

first = [-p1(1,:)'.*p2(1,:)' -p1(1,:)'.*p2(2,:)' -p1(1,:)']';
first = first(:);
second = [-p1(2,:)'.*p2(1,:)' -p1(2,:)'.*p2(2,:)' -p1(2,:)']';
second = second(:);
third = [first second]';
s = repmat(3,1,size(third,2)/3);
C = mat2cell(third,2,s);
C = C(:);
third = cell2mat(C);
eq = [left third];
[~,~,V] = svd(eq);
H2to1 = V(:,end);
H2to1 = reshape(H2to1,3,3)';
% H2to1 = H2to1(:,end)';
% CH = mat2cell(H2to1,1,[3 3 3]);
% CH = CH(:);
% H2to1 = cell2mat(CH);
% H2to1 = reshape(H2to1,3,[]);
% H2to1 = inv(H2to1);