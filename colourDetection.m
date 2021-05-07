clear;
clc;

% INITIALISATION

%variables
totalCups = 2;
totalBalls = 4;
load('cameraParams.mat');

cameraHeight = 0.65; %m 
ballDiameter = 0.04; %m
cupHeight = 0.1; %m

%set up the webacm
cam = webcam('USB Camera')

% OBJECT DETECTION

%detect objects in the image
r_obj = findObjects(cam,1,0.15,0);
%g_obj = findObjects(cam,2,0.1,1);
b_obj = findObjects(cam,3,0.1,0);

all_obj = [r_obj;b_obj]; % will need to add green once i figure it out. 
    
[cups, balls] = findBallsAndCups(all_obj,totalCups,totalBalls);

%display image
img = snapshot(cam);
imshow(img);
hold on;
for(i=1:length(cups))
    rectangle('position',cups(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
    plot(cups(i).Centroid(1), cups(i).Centroid(2), '+b');
    hold on;
end
for(i=1:length(balls))
    rectangle('position',balls(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
    plot(balls(i).Centroid(1), balls(i).Centroid(2), '+b');
    hold on;
end


% WORLD COORDINATE CALCULATION
cups = determineCoordinates(cups,cameraParams,cameraHeight,cupHeight);
balls = determineCoordinates(balls,cameraParams,cameraHeight,ballDiameter);
