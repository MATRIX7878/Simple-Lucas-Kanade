function [Z] = compute2x2gradmat(gx,gy,i,j,window)

%Get basic info
[height width numcolors] = size(gx);

%Initialize Z matrix
ixx=0;
iyy=0;
ixy=0;

w=floor(window/2);

%Loop over every pixel to create the Z matrix
for offseti=-w:w
    for offsetj=-w:w
        if i+offseti < height  && j+offsetj < width
            gx_inter=Interpolate(gx, i+offseti, j+offsetj);
            gy_inter=Interpolate(gy, i+offseti, j+offsetj);
            ixx = ixx + gx_inter^2;
            iyy = iyy + gy_inter^2;
            ixy = gx_inter*gy_inter;
        end
    end
end

Z = [ixx ixy;ixy iyy];

end

