function [Gderiv,wd] = gaussianderiv(sigma)

%Find the Gaussian Derivative for same width as the Kernel Gauss

a=round(2.5*sigma-.5);
wd=2*a+1;
sum=0;

for i = 1:wd
    Gderiv(i)=-(i-1-a)*exp((-(i-1-a)*(i-1-a))/(2*sigma^2));
    sum=sum-i*Gderiv(i);
end

Gderiv=Gderiv/sum;

end

