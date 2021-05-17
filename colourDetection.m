clear;
clc;

% INITIALISATION

%variables
totalCups = 2;
totalBalls = 2;
load('cameraParams.mat');

cameraHeight = 0.65; %m 
ballDiameter = 0.04; %m
cupHeight = 0.1; %m

%set up the webacm
cam = webcam('USB Camera')

[Cups, Balls, cups_tmp, balls_tmp] = detectObjects(totalCups,totalBalls,cam,cameraParams,cameraHeight,ballDiameter,cupHeight,1);

% % OBJECT DETECTION
%  
% %detect objects in the image
% r_obj = findObjects(cam,1,0.15,0);
% %g_obj = findObjects(cam,2,0.1,1);
% b_obj = findObjects(cam,3,0.1,0);
% 
% %all_obj = [r_obj;g_obj;b_obj];
% all_obj = [r_obj;b_obj]; % will need to add green once i figure it out. 
%     
% [cups, balls] = findBallsAndCups(all_obj,totalCups,totalBalls);
% 
% %display image
% img = snapshot(cam);
% imshow(img);
% hold on;
% for(i=1:length(cups))
%     rectangle('position',cups(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
%     plot(cups(i).Centroid(1), cups(i).Centroid(2), '+b');
%     hold on;
% end
% for(i=1:length(balls))
%     rectangle('position',balls(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
%     plot(balls(i).Centroid(1), balls(i).Centroid(2), '+b');
%     hold on;
% end
% 
% 
% % WORLD COORDINATE CALCULATION
% cups_tmp = determineCoordinates(cups,cameraParams,cameraHeight,cupHeight);
% balls_tmp = determineCoordinates(balls,cameraParams,cameraHeight,ballDiameter);
% 
% 
% % PUT IT IN CORRECT FORMAT
% 
% r_b = returnRed(balls_tmp)
% %g_b = returnGreen(balls_tmp)
% b_b = returnBlue(balls_tmp)
% 
% Balls{1} = r_b;
% Balls{2} = b_b
% 
% %Balls{1} = r_b;
% %Balls{2} = g_b;
% %Balls{3} = b_b;
% 
% r_c = returnRed(cups_tmp);
% b_c = returnBlue(cups_tmp);
% 
% Cups{1} = r_c;
% Cups{2} = b_c

%% video boundaries
cam = webcam('USB Camera');

while(1)
    r_obj = findObjects(cam,1,0.1,0);
    g_obj = findObjects(cam,2,0.1,0);
    b_obj = findObjects(cam,3,0.09,0);
    
    all_obj = [r_obj;g_obj;b_obj];
    
%     for i=1:length(all_obj)
% 
%        if all_obj(i).Area < 10000
%           all_obj(i) = [];
%        end
%     end
    totalLength = length(all_obj);
    i = 1;
    while i < totalLength
        
       if all_obj(i).Area < 10000
          all_obj(i) = [];
          totalLength = totalLength - 1
       end
       i = i+1;
       
    end

    
    
    img = snapshot(cam);
    imshow(img);
    hold on;
    for(i=1:length(all_obj))
        rectangle('position',all_obj(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
        plot(all_obj(i).Centroid(1), all_obj(i).Centroid(2), '+b');
        hold on;
    end
    
    
    
end