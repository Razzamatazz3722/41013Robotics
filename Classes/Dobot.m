classdef Dobot < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
         model;
        
        %>
        workspace = [-0.2 1 -1 1 -0.3 1];
    end
    
    methods
        
function self = Dobot()
    
    self.GetDobotRobot;

    q = zeros(1,4);
    self.model.plot(q,'fps',25,'workspace',self.workspace,'scale',0.5);

end
      
function GetDobotRobot(self)
    %DH parameters for the dobot
    L1 = Link('a',0,'d',0.08,'alpha',deg2rad(90),'offset',0,'qlim',[deg2rad(-90),deg2rad(90)]);
    L2 = Link('a',0.135,'d',0,'alpha',0,'qlim',[0,deg2rad(85)]);
    L3 = Link('a',0.16,'d',0,'alpha',0,'qlim',[deg2rad(-90),deg2rad(10)]);
    L4 = Link('a',0,'d',0,'alpha',deg2rad(90),'qlim',[deg2rad(-90),deg2rad(90)]);

    self.model = SerialLink([L1 L2 L3 L4],'name','Dobot');
end
    
    
    
    
    % function outputArg = method1(obj,inputArg)
%     %METHOD1 Summary of this method goes here
%     %   Detailed explanation goes here
%     outputArg = obj.Property1 + inputArg;
% end
    end
end