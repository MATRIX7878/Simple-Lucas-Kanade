function [err] = compute2x1errvect(I,J,gx,gy,i,j,window,u)

%Basic info about horizontal image
[height width numcolors] = size(gx);

%Start with new error function
w=floor(window/2);
err = zeros(2,1);

%Loop over all pixels and interpolate the data to get an error vector
for offseti=-w:w
    for offsetj=-w:w
        if i+offseti < height  && j+offsetj < width && i + offseti > 0 && j + offsetj > 0
            gx_inter=Interpolate(gx, i+offseti, j+offsetj);
            gy_inter=Interpolate(gy, i+offseti, j+offsetj);
            
            I_inter=Interpolate(I, i+offseti, j+offsetj);
            J_inter=Interpolate(J, i+u(2)+offseti, j+u(1)+offsetj);
            
            err(1) = err(1) + gx_inter*(I_inter-J_inter);
            err(2) = err(2) + gy_inter*(I_inter-J_inter);
        end
    end
end

end

