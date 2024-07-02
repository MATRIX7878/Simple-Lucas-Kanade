function [gx,gy]=getgrad(I,sigma)

%Get the 2 gaussian kernals
[gauss] = colnelgauss(sigma);
[gauss_deriv] = gaussianderiv(sigma);

%Only the horizontal and vertical images matter
[gx, gy, ~, ~] = maggrad(I,gauss,gauss_deriv);
end