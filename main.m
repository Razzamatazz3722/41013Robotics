clf; clear; clc; 

%% Setup and Load Workspace:
% load workspace
Workspace();

% Call the classes for the Cup and Ball
Cup;
PingPongBall; 
%Dobot;


%% Robot Initialisation
clearvars
rosshutdown
rosinit('10.42.0.1');

bot = OtherDobotFunctions(); 
pause(2);
%%
%bot.initialise();
%pause(10);
% Check Status of the robot
status = bot.getCurrentDobotSafetyStatus();
if(status ~= 4)
    inp = input('Robot is NOT operational. Do you want to continue? [y,n]: ', 's');
    if inp=='n'
        display('program terminated');
    end
end
%bot.setNeutralPosition([0,0,0,0]);


%% Testing

bot.setTargetJointState([0,0,0,0]);
input('Press any key to continue');


bot.setTargetJointState([-1.05,0,0,0]);
input('Press any key to continue');
bot.setTargetJointState([-1.05,0.7,0.80,0]);
input('Press any key to continue');
bot.setTargetJointState([-1.05,0.7,0.85,0]);

input('To start the airpump, press any key to continue');
bot.setToolState(1);
input('Press any key to continue');
bot.setTargetJointState([0,0,0,0]);
input('Press any key to continue');
bot.setToolState(0);
<<<<<<< HEAD
%%
cam = webcam('USB Camera');
bot.setToolState(1);
triangle = [0,0,0];
while(1)

    
    rgbImage = snapshot(cam);

    [BW,maskedRGBImage] = createMaskYellow(rgbImage);
=======

%% Dancing
for i=1:4
    bot.setTargetJointState([0,0,0,0]);
    %input('Press any key to continue');
    bot.setTargetJointState([0.5,0,0.8,0]);
    %input('Press any key to continue');
end
for i=1:4
    bot.setTargetJointState([0,0,0,0]);
    %input('Press any key to continue');
    bot.setTargetJointState([-0.5,0,0.8,0]);
    %input('Press any key to continue');
end
for i=1:4
    bot.setTargetJointState([-0.5,0,-0.1,0]);
    %input('Press any key to continue');
    bot.setTargetJointState([0.5,0,-0.1,0]);
    %input('Press any key to continue');
end


%%
bot.setToolState(0);
>>>>>>> 1df4d24302322878bd136b1367446d791b30894a

    BW = imfill(BW, 'holes');
    imshow(BW);
    labeledImage = bwlabel(BW, 8);
    blobMeasurements = regionprops(labeledImage, 'Perimeter', 'Area', 'Centroid', 'BoundingBox');

    for i = 1:length(blobMeasurements)
        Circularities = [blobMeasurements(i).Perimeter].^2 ./ (4 * pi * [blobMeasurements(i).Area])
        C = num2cell(Circularities);
        [blobMeasurements(i).Circularity] = deal(C{:});
    end
    for i=1:length(blobMeasurements)
        circ = blobMeasurements(i).Circularity
        area = blobMeasurements(i).Area
        if (blobMeasurements(i).Circularity > 1.18) & (blobMeasurements(i).Circularity < 1.25) & (blobMeasurements(i).Area > 1000)
            display('object is triangle');
            triangle = circshift(triangle,-1);
            triangle(end)=1
        elseif (blobMeasurements(i).Area > 10000)
            display('object not triangle');
            triangle = circshift(triangle,-1);
            triangle(end)=0
        end
        
        if sum(triangle) == 3
            bot.setToolState(0);
            display('break');
            break;
        end

    end

  
    
%     
%     if(triangle == 1)
%         bot.setToolState(0);
%         break;
%     end
    
end

display('hi');

%% Variable Initialisation

%variables
totalCups = 2;
totalBalls = 6;
load('cameraParams.mat');

cameraHeight = 0.65; %m 
ballDiameter = 0.04; %m
cupHeight = 0.1; %m

%set up the webacm
cam = webcam('USB Camera');

x = 1;
y = 2;
z = 3;


%% Loop

input('Press any key to continue');

% Get updated ball and cup list
[Cups, Balls] = detectObjects(totalCups,totalBalls,cam,cameraParams,cameraHeight,ballDiameter,cupHeight,1);
    
   
% for each colour of ball
for i=1:length(Balls)
   
    % for each ball of that colour
    for j=1:length(Balls{i})      
        
        % initialisation waypoint
        bot.goToNeutralPosition();
        
        % set variables
        nextBall = Balls{i}(j);
        nextCup = Cups{i}(1);
        
        % go to ball
        bot.setTargetEndEffectorState(obj,[nextBall(x),nextBall(y),nextBall(z)],[0,0,0]);
        pause(5);
        
        %turn on suction cup
        bot.setToolState(1);
        pause(2);
        
        % go to neutral position
        bot.goToNeutralPosition();
        pause(5);
        
        % go to above cup
        bot.setTargetEndEffectorState(obj,[nextBall(x),nextBall(y),nextBall(z)+5],[0,0,0]);
        pause(5);
        
        % do weird move thing
        
        
        
        % release ball
        bot.setToolState(0);
        pause(2);
        
    end

end