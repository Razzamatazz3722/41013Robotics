clf; clear; clc; 

%% Setup and Load Workspace:
% load workspace
Workspace();

% Call the classes for the Cup and Ball
Cup;
PingPongBall; 
Dobot;

%%
%c1 = Cup(transl(1.5,1.5,0), 'RedCup.ply', 'redcup');

%% Start ROS

clearvars
rosshutdown
rosinit

% Subscribe to depth adn RGB messages
depthRawSub = rossubscriber('/camera/depth/image_raw'); % Depends upon the camera in use (refer to instructions)
rgbRawSub = rossubscriber('/camera/rgb/image_raw'); % Depends upon the camera in use (refer to instructions)
pause(2);
depthImg = readImage(depthRawSub.LatestMessage);
rgbImg = readImage(rgbRawSub.LatestMessage);