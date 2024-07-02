function [horizontal,vertical,magnitude,gradient] = maggrad(image,gauss,gaussderiv)

%Get some basic information about the image.
[height,width,numcolors]=size(image);

gaussderiv = fliplr(gaussderiv);

%Convolve the image with the gauss kernel, then the gauss derivative to get
%horizontal and vertical
temp_horizontal = convolvo(image,gauss');
horizontal = convolvo(temp_horizontal,gaussderiv);

temp_vertical = convolvo(image,gauss);
vertical = convolvo(temp_vertical,gaussderiv');

magnitude = zeros(height,width);
gradient = zeros(height,width);

%Fill in the magnitude and gradient images
for i = 1:height
    for j = 1:width
        magnitude(i,j) = sqrt(vertical(i,j)^2+horizontal(i,j)^2);
        gradient(i,j) = atan2(horizontal(i,j),vertical(i,j));
    end
end

end