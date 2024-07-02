function [G,wk] = colnelgauss(sigma)

%Find the Gaussian Kernel

a = round(2.5*sigma-.5);
wk=2*a+1;
sum = 0;

for i=1:wk
    G(i) = exp((-(i-1-a)*(i-1-a))/(2*sigma^2));
    sum=sum+G(i);
end

G=G/sum;

end

