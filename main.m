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

% Check Status of the robot
% status = dobotSafetyStatus('/dobot_magician/safety_status');
% if(status ==1)
%     inp = input('Robot is not operational. Do you want to continue? [y,n]: ', 's');
%     if inp=='n'
%         display('program terminated');
%     end
% end
status = dobotSafetyStatus('/dobot_magician/safety_status');
if(status ~= 4)
    inp = input('Robot is not operational. Do you want to continue? [y,n]: ', 's');
    if inp=='n'
        display('program terminated');
    end
end

% Initialisation command
[safetyStatePublisher,safetyStateMsg] = rospublisher('/dobot_magician/target_safety_status');
safetyStateMsg.Data = 2;
send(safetyStatePublisher,safetyStateMsg);


