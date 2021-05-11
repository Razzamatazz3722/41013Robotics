classdef OtherDobotFunctions
    
    properties (Access = private)
        jointStateSubscriber;
        endEffectorPoseSubscriber;
        toolStateSubscriber;
        safetyStatusSubscriber;
    end
    
    methods
        function obj = OtherDobotFunctions()
            obj.jointStateSubscriber = rossubscriber('/dobot_magician/joint_states'); % Create a ROS Subscriber to the topic joint_states
            obj.endEffectorPoseSubscriber = rossubscriber('/dobot_magician/end_effector_poses'); % Create a ROS Subscriber to the topic end_effector_poses
            obj.toolStateSubscriber = rossubscriber('/dobot_magician/tool_state');
            obj.safetyStatusSubscriber = rossubscriber('/dobot_magician/safety_status');
            pause(2);
        end
        
        function currentDobotState = getCurrentDobotSafetyStatus(obj)
            currentSafetyStatus = obj.safetyStatusSubscriber.LatestMessage.Data;
            
            if(currentSafetyStatus == 0)
                display("DOBOT STATUS: INVALID");
            elseif(currentSafetyStatus == 1)
                display("DOBOT STATUS: DISCONNECTED");
            elseif(currentSafetyStatus == 2)
                display("DOBOT STATUS: INITIALISING");
            elseif(currentSafetyStatus == 3)
                display("DOBOT STATUS: ESTOPPED");
            elseif(currentSafetyStatus == 4)
                display("DOBOT STATUS: OPERATIONAL");
            elseif(currentSafetyStatus == 5)
                display("DOBOT STATUS: PAUSED");
            elseif(currentSafetyStatus == 6)
                display("DOBOT STATUS: STOPPED");
            end
        end
        
        function currentJointState = getCurrentJointState(obj)
            currentJointState = obj.jointStateSubscriber.LatestMessage.Position % Get the latest message
        end
        
        function [roll,pitch,yaw] = getCurrentEndEffectorPose(obj)
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
        
        function setTargetJointState(obj, jointTarget)
            %jointTarget = [0,0.4,0.3,0]; % Remember that the Dobot has 4 joints by default.
            [targetJointTrajPub,targetJointTrajMsg] = rospublisher('/dobot_magician/target_joint_states');
            trajectoryPoint = rosmessage("trajectory_msgs/JointTrajectoryPoint");
            trajectoryPoint.Positions = jointTarget;
            targetJointTrajMsg.Points = trajectoryPoint;

            send(targetJointTrajPub,targetJointTrajMsg);
        end
        
        function setTargetEndEffectorState(obj,endEffectorPosition,endEffectorRotation)
            %endEffectorPosition = [0.2,0,0.1];
            %endEffectorRotation = [0,0,0];

            [targetEndEffectorPub,targetEndEffectorMsg] = rospublisher('/dobot_magician/target_end_effector_pose');

            targetEndEffectorMsg.Position.X = endEffectorPosition(1);
            targetEndEffectorMsg.Position.Y = endEffectorPosition(2);
            targetEndEffectorMsg.Position.Z = endEffectorPosition(3);

            qua = eul2quat(endEffectorRotation);
            targetEndEffectorMsg.Orientation.W = qua(1);
            targetEndEffectorMsg.Orientation.X = qua(2);
            targetEndEffectorMsg.Orientation.Y = qua(3);
            targetEndEffectorMsg.Orientation.Z = qua(4);

            send(targetEndEffectorPub,targetEndEffectorMsg); 
        end
        
        function currentToolState = getCurrentToolState(obj)
            currentToolState = obj.toolStateSubscriber.LatestMessage.Data;
            
            if(currentToolState == 0)
                display("TOOL STATUS: OFF");
            elseif(currentToolState == 1)
                display("DOBOT STATUS: ON");
            end
        end
        
        function setToolState(obj)
            % Turn on the tool
            [toolStatePub, toolStateMsg] = rospublisher('/dobot_magician/target_tool_state');
            toolStateMsg.Data = [1]; % Send 1 for on and 0 for off 
            send(toolStatePub,toolStateMsg);
        end
    end
end

