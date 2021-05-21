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