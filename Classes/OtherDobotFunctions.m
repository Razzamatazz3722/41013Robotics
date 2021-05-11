classdef OtherDobotFunctions
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = OtherDobotFunctions()
            
        end
        
        function currentJointState = getCurrentJointState(obj,inputArg)
            jointStateSubscriber = rossubscriber('/dobot_magician/joint_states'); % Create a ROS Subscriber to the topic joint_states
            pause(2); % Allow some time for a message to appear
            currentJointState = jointStateSubscriber.LatestMessage.Position % Get the latest message
        end
    end
end

