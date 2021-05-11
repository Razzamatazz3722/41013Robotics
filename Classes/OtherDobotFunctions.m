classdef OtherDobotFunctions
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        jointStateSubscriber;
        endEffectorPoseSubscriber
    end
    
    methods
        function obj = OtherDobotFunctions()
            obj.jointStateSubscriber = rossubscriber('/dobot_magician/joint_states'); % Create a ROS Subscriber to the topic joint_states
            obj.endEffectorPoseSubscriber = rossubscriber('/dobot_magician/end_effector_poses'); % Create a ROS Subscriber to the topic end_effector_poses
            pause(2);
        end
        
        function currentJointState = getCurrentJointState(obj)
            currentJointState = obj.jointStateSubscriber.LatestMessage.Position % Get the latest message
        end
        
        function [roll,pitch,yaw] = getCurrentEndEffectorPose()
            currentEndEffectorPoseMsg = obj.endEffectorPoseSubscriber.LatestMessage;
            % Extract the position of the end effector from the received message
            currentEndEffectorPosition = [currentEndEffectorPoseMsg.Pose.Position.X,
                                          currentEndEffectorPoseMsg.Pose.Position.Y,
                                          currentEndEffectorPoseMsg.Pose.Position.Z];
            % Extract the orientation of the end effector
            currentEndEffectorQuat = [currentEndEffectorPoseMsg.Pose.Orientation.W,
                                      currentEndEffectorPoseMsg.Pose.Orientation.X,
                                      currentEndEffectorPoseMsg.Pose.Orientation.Y,
                                      currentEndEffectorPoseMsg.Pose.Orientation.Z];
            % Convert from quaternion to euler
            [roll,pitch,yaw] = quat2eul(currentEndEffectorQuat); 
        end
    end
end

