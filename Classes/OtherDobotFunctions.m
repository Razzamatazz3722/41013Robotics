classdef OtherDobotFunctions
    
    properties (Access = private)
        jointStateSubscriber;
        endEffectorPoseSubscriber;
        toolStateSubscriber;
        safetyStatusSubscriber;
        
        targetJointTrajPub;
        targetJointTrajMsg;
        
        targetEndEffectorPub;
        targetEndEffectorMsg;
        
        toolStatePub;
        toolStateMsg;
        
        safetyStatePub;
        safetyStateMsg;
        
    end
    
    properties
       neutralPosition; 
        
    end
    
    methods
        function obj = OtherDobotFunctions()
            rostopic list %for testing
            obj.safetyStatusSubscriber = rossubscriber('/dobot_magician/safety_status');
            obj.jointStateSubscriber = rossubscriber('/dobot_magician/joint_states'); % Create a ROS Subscriber to the topic joint_states
            obj.endEffectorPoseSubscriber = rossubscriber('/dobot_magician/end_effector_poses'); % Create a ROS Subscriber to the topic end_effector_poses
            obj.toolStateSubscriber = rossubscriber('/dobot_magician/tool_state');
            [obj.targetJointTrajPub,obj.targetJointTrajMsg] = rospublisher('/dobot_magician/target_joint_states');
            [obj.targetEndEffectorPub,obj.targetEndEffectorMsg] = rospublisher('/dobot_magician/target_end_effector_pose');
            [obj.toolStatePub, obj.toolStateMsg] = rospublisher('/dobot_magician/target_tool_state');
            [obj.safetyStatePub,obj.safetyStateMsg] = rospublisher('/dobot_magician/target_safety_status');
           
            
        end
        
        function initialise(obj)
            obj.safetyStateMsg.Data = 2;
            send(obj.safetyStatePub,obj.safetyStateMsg);
            display("DOBOT INITIALISING...");
            pause(2);
        end
        
        function eStop(obj)
            obj.safetyStateMsg.Data = 3;
            send(obj.safetyStatePub,obj.safetyStateMsg);
            display("ESTOP");
            pause(2);
        end
        
        function setMode(obj,mode)
            obj.safetyStateMsg.Data = mode;
            send(obj.safetyStatePub,obj.safetyStateMsg);
            if(mode == 0)
                display("DOBOT STATUS: INVALID");
            elseif(mode == 1)
                display("DOBOT STATUS: DISCONNECTED");
            elseif(mode == 2)
                display("DOBOT STATUS: INITIALISING");
            elseif(mode == 3)
                display("DOBOT STATUS: ESTOPPED");
            elseif(mode == 4)
                display("DOBOT STATUS: OPERATIONAL");
            elseif(mode == 5)
                display("DOBOT STATUS: PAUSED");
            elseif(mode == 6)
                display("DOBOT STATUS: STOPPED");
            end
            pause(2);
        end
        
        function currentSafetyStatus = getCurrentDobotSafetyStatus(obj)
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
            latestJointStateMsg = obj.jointStateSubscriber.LatestMessage % Get the latest message
            currentJointState = latestJointStateMsg.Position;
        end
        
        function [currentEndEffectorPosition, currentEndEffectorQuat] = getCurrentEndEffectorPose(obj)
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
                                  
              
%             % Convert from quaternion to euler
%             [roll,pitch,yaw] = quat2eul(currentEndEffectorQuat); 
        end
        
        function setTargetJointState(obj, jointTarget)
            %jointTarget = [0,0.4,0.3,0]; % Remember that the Dobot has 4 joints by default.
            trajectoryPoint = rosmessage("trajectory_msgs/JointTrajectoryPoint");
            trajectoryPoint.Positions = jointTarget;
            obj.targetJointTrajMsg.Points = trajectoryPoint;

            send(obj.targetJointTrajPub,obj.targetJointTrajMsg);
            %pause(2);
        end
        
        function setTargetEndEffectorState(obj,endEffectorPosition,endEffectorRotation)
            %endEffectorPosition = [0.2,0,0.1];
            %endEffectorRotation = [0,0,0];
            obj.targetEndEffectorMsg.Position.X = endEffectorPosition(1);
            obj.targetEndEffectorMsg.Position.Y = endEffectorPosition(2);
            obj.targetEndEffectorMsg.Position.Z = endEffectorPosition(3);

            qua = eul2quat(endEffectorRotation);
            obj.targetEndEffectorMsg.Orientation.W = qua(1);
            obj.targetEndEffectorMsg.Orientation.X = qua(2);
            obj.targetEndEffectorMsg.Orientation.Y = qua(3);
            obj.targetEndEffectorMsg.Orientation.Z = qua(4);

            send(obj.targetEndEffectorPub,obj.targetEndEffectorMsg); 
        end
        
        function currentToolState = getCurrentToolState(obj)
            currentToolState = obj.toolStateSubscriber.LatestMessage.Data;
            
            if(currentToolState == 0)
                display("TOOL STATUS: OFF");
            elseif(currentToolState == 1)
                display("DOBOT STATUS: ON");
            end
        end
        
        function setToolState(obj, state)
            % Turn on the tool
            [obj.toolStatePub, obj.toolStateMsg] = rospublisher('/dobot_magician/target_tool_state');
            obj.toolStateMsg.Data = [state]; % Send 1 for on and 0 for off 
            send(obj.toolStatePub,obj.toolStateMsg);
        end
        
        function goToNeutralPosition(obj)
            obj.setTargetJointState(obj.neutralPosition);
        end
        
        function setNeutralPosition(obj,position)
           obj.neutralPosition = position; 
        end
    end
end

