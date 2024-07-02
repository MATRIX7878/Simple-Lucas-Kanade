%Load in pictures
file = input('What folder do you want to use: flowergarden (f), or statue_seq (s)? ','s');

%This code assumes that the folders that have the pictures are in the same
%parent folder

%Flower garden
if file == 'f'
    [FileName,FilePath]=uigetfile('.\flowergarden\img030.pgm');
    I=imread(strcat(FilePath,FileName));
    %Ask if ginput or Shi Tusami will be used
    line='Do you want to manually (m) or automatically (a) detect the points?\nThe auto function is a bit buggy, but at least you dont have to click.  The manual function is fine, but you cant see what you have hit. ';
    detector = input(line,'s');
    imshow(I)
    title('Selected Features')
    truesize([500 500])
    %Either will pick best 21 points
    if detector == 'a'
        [x, y] = shitomasi(I);
    elseif detector == 'm'
        [x y]=ginput(21);
    else
        error("You will be Roger-Rogered soon")
    end        
    hold on
    %Add the X's to the picture
    text(x,y,'x','color','r','FontSize',16)
    pause(.1)
    topfeatures = [x y];
    for filenum = 30:57
        %Loop over every picture in the folder
        filename = sprintf('img0%d.pgm',filenum);
        I=imread(strcat(FilePath,filename));
        filenum = filenum + 1;
        %This is the next photo in the folder to compare to
        filename = sprintf('img0%d.pgm',filenum);
        J=imread(strcat(FilePath,filename));
        imshow(J)
        hold on
        %Convert to double to do the algebra
        I=double(I);
        J=double(J);
        %Apply Lucas Kanade
        [topfeatures] = Lucas_Kanade(I,J,topfeatures,5,21);
        title('Movie of Feature Points')
        %Put up next photo with updated X's
        text(topfeatures(:,1),topfeatures(:,2),'x','color','r','FontSize',16)
        pause(.1)
    end
%Statue Sequence
%Follows same path as the above.  Only difference is pictures and # being
%inputted into sprintf
elseif file == 's'
    [FileName,FilePath]=uigetfile('.\statue_seq\img0588.bmp');
    I=imread(strcat(FilePath,FileName));
    line='Do you want to manually (m) or automatically (a) detect the points?\nThe auto function is a bit buggy, but at least you dont have to click.  The manual function is fine, but you cant see what you have hit. ';
    detector = input(line,'s');
    imshow(I)
    title('Selected Features')
    truesize([500 500])
    if detector == 'a'
        [x, y] = shitomasi(I);
    elseif detector == 'm'
        [x y]=ginput(21);
    else
        error("You will be Roger-Rogered soon")
    end
    hold on
    text(x,y,'x','color','r','FontSize',16)
    pause(.1)
    topfeatures = [x y];
    for filenum = 588:617
        filename = sprintf('img0%d.bmp',filenum);
        I=imread(strcat(FilePath,filename));
        filenum = filenum + 1;
        filename = sprintf('img0%d.bmp',filenum);
        J=imread(strcat(FilePath,filename));
        imshow(J)
        I=double(I);
        J=double(J);
        hold on
        [topfeatures] = Lucas_Kanade(I,J,topfeatures,5,21);
        title('Movie of Feature Points')
        text(topfeatures(:,1),topfeatures(:,2),'x','color','r','FontSize',16)
        pause(.1)
    end
else
    error("Not a valid option.  You get a F in typing")
end