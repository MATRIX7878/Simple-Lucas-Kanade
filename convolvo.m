function [conimage] = convolvo(image,kernal)

%Convolve the image using the Gauss Kernel found before

%Get some basic information about the image.
[heighti,widthi,numcolors]=size(image);

%Get some basic information about the kernal.
[heightk,widthk]=size(kernal);

conimage = zeros(heighti,widthi);

sum = 0;

%Move Kernel around entire picture
for i = 1:heighti
    for j = 1:widthi
        for k = 1:heightk
            for m = 1:widthk
                offseti=-floor(heightk/2)+k-1;
                offsetj=-floor(widthk/2)+m-1;
                if i+offseti > 0 && i + offseti<heighti && j+offsetj>0 && j+offsetj<widthi
                    if image(i+offseti,j+offsetj)
                        sum = sum + image(i+offseti,j+offsetj)*kernal(k,m);
                    end
                end
            end
        end
        conimage(i,j)=sum;
        sum = 0;
    end
end

end