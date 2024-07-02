function [topfeatures] = Lucas_Kanade(I,J,topfeatures,window,numfeatures)

%Get the horizontal and vertical gradients
[gx gy] = getgrad(I,.6);

for featurenum = 1:numfeatures
    %Make sure that the feature exists within the confinds on the image
    if ~isnan(topfeatures(featurenum,1)) && ~isnan(topfeatures(featurenum,2)) && topfeatures(featurenum,1) > 0 && topfeatures(featurenum,2) > 0
        %i is vertical
        i=topfeatures(featurenum,2);
        %j is horizontal
        j=topfeatures(featurenum,1);
        u=zeros(2,1);
        deltau=zeros(2,1);

        %Compute the gradient matrix
        [Z] = compute2x2gradmat(gx,gy,i,j,window);

        %Start to count iterations to not over loop
        iter = 0;
        while 1
            %Solve Error vector and the system of linear equations
            [err] = compute2x1errvect(I,J,gx,gy,i,j,window,u);
            [deltau] = solve2x2linsys(Z,err);
   
            %Apply changes to pixels
            u(1)=u(1)+deltau(1);
            u(2)=u(2)+deltau(2);

            iter = iter +1;

            %More than 10 iterations is to many
            if iter > 10
                break
            end

            %Make sure the change is big
            udelta=sqrt(deltau(1)^2+deltau(2)^2);

            if udelta <= .2
                break
            end
        end

        %Update coordinates
        topfeatures(featurenum,1) = topfeatures(featurenum,1) + u(1);
        topfeatures(featurenum,2) = topfeatures(featurenum,2) + u(2);
        
    end

end

end