function demoSafetySymbol(bot)

%%
cam = webcam('USB Camera');
F1 = figure('Name','Safety Symbol detection');

triangle = [0,0,0];
while(1)
    
    result = checkForSafetySymbol(cam)
    
    if result == 1
        result = result + checkForSafetySymbol(cam)
        result = result + checkForSafetySymbol(cam)
    end
    
    if result == 3
        display('safety symbol detected');
        bot.setTargetJointState([0,0,1.2,0]);
        return;
        input('press any key to continue');
    else
        display('move to random point');
        %pick a random point
        %joint 1
        j1 = 0.5+(-0.5-0.5).*rand
        %joint 2
        j2 = 0.8+(0-0.8).*rand
        %joint 3
        j3 = 0.7+(-0.2-0.7).*rand
        %joint 4
        j4 = 0;
        
        bot.setTargetJointState([j1,j2,j3,j4]);
        pause(1);
    end
    
end

%%

    function result = checkForSafetySymbol(cam)
        
        %rgbImage = snapshot(cam);
        rgbImage = snapshot(cam);
        
        [BW,maskedRGBImage] = createMaskYellow(rgbImage);
        
        BW = imfill(BW, 'holes');
        figure(F1); imshow(BW);
        labeledImage = bwlabel(BW, 8);
        blobMeasurements = regionprops(labeledImage, 'Perimeter', 'Area', 'Centroid', 'BoundingBox');
        
        if(length(blobMeasurements)>0)
            T = struct2table(blobMeasurements);
            sortedT = sortrows(T, 'Area', 'descend');
            sortedObj = table2struct(sortedT);
            circ = [sortedObj(1).Perimeter].^2 ./ (4 * pi * [sortedObj(1).Area])
            
            if (circ > 1.18) & (circ < 1.25)
                display('object could be safety symbol');
                %triangle = circshift(triangle,-1);
                %triangle(end)=1;
                result = 1;
                
            else
                display('object not triangle');
                %triangle = circshift(triangle,-1);
                %triangle(end)=0;
                result = 0;
            end
        else
            result = 0;
        end
        
    end

    function rmrcRetreat()
        
        
        
    end

end

