classdef Dobot
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
         %> Robot model
        model;
        %>
        workspace = [-2.3 2.3 -2.3 2.3 0 2.3];
        
        %> Flag to indicate if gripper is used
        useGripper = false;
    end
    
    methods
        
        function self = UR3(useGripper)
            if nargin < 1
                useGripper = false;
            end
            self.useGripper = useGripper;
        
            % robot =
            self.GetDobotRobot();
            
            % robot =
            self.PlotAndColourRobot();%robot,workspace);
        end
        
        function GetDobotRobot(self)
            %     if nargin < 1
            % Create a unique name (ms timestamp after 1ms pause)
            pause(0.001);
            name = ['Dobot',datestr(now,'yyyymmddTHHMMSSFFF')];
            %     end
            
            L1 = Link('a',0,'d',0.08,'alpha',90,'qlim',[deg2rad(-90),deg2rad(90)])
            L2 = Link('a',deg2rad(130),'d',0,'alpha',0,'qlim',[0,deg2rad(85)])
            L3 = Link('a',deg2rad(160),'d',0,'alpha',0,'qlim',[deg2rad(-10),deg2rad(90)])
            L4 = Link('a',0,'d',0,'alpha',0,'qlim',[deg2rad(-90),deg2rad(90)])
  
            self.model = SerialLink([L1 L2 L3 L4],'name',name);
        end
        
      %% PlotAndColourRobot
        %Given a robot index, add the glyphs (vertices and faces) and
        %colour them in if data is available
        function PlotAndColourRobot(self)%robot,workspace)
            
            end
            
            %Display robot
            q = (0 0 0 0 0 0)
            self.model.plot(q,'fps',25,'workspace',obj.workspace,'scale',0.5);
          
        end
    end
end

