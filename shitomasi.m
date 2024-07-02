function [y, x] = shitomasi(image)

%Get size of image
[height width numcolor] = size(image);

%Get Horizontal and Vertical images
[gx gy] = getgrad(image,.6);

%Initiate the corner identifier
cornerness = zeros(height,width);

%Calculate the eigenvalues
for i = 1:height
    for j = 1:width
        [Z] = compute2x2gradmat(gx,gy,i,j,5);
        eigen = eig(Z);
        cornerness(i,j)=min(eigen);
    end
end

%Get the max of the cornerness matrix
i = maxk(cornerness,21,2);
i = max(maxk(i,22));

x = [];
y=[];

%Get pixels of best pixels
for a=1:height
    for b=1:width
        for c=1:length(i)
            if cornerness(a,b) == i(c)
                x = [a x];
                y = [b y];
            end
        end
    end
end    
 
x=x';
y=y';

end