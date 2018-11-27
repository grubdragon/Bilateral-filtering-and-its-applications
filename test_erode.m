sum=0
for i = 1:10
    A = rand(10,10);
    A = A>0.5
    se = [0,1,0;1,1,1;0,1,0];
    K = imerode(A,se)~=erode(A,se);
    sum = sum + sum(K(:))
end