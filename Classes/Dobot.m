classdef Dobot < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
         model;
        
        %>
        workspace = [-2.3 2.3 -2.3 2.3 0 2.3];
    end
    
    methods
        
function self = Dobot()
    
    self.GetDobotRobot;

    %q = zeros(1,4);
    q = deg2rad([0 30 40 0]);
    %self.model.base = transl(-1,0,0.75) *trotz(-90*pi/180);
    self.model.plot(q,'fps',25,'noarrow','workspace',self.workspace,'scale',0.25);

end
      
function GetDobotRobot(self)
    %DH parameters for the dobot
    L1 = Link('a',0,'d',0.08,'alpha',deg2rad(90),'offset',deg2rad(180),'qlim',[deg2rad(-90),deg2rad(90)]);
    L2 = Link('a',0.135,'d',0,'alpha',0,'offset',deg2rad(90),'qlim',[5,deg2rad(80)]);
    L3 = Link('a',0.147,'d',0,'alpha',0,'offset',deg2rad(90),'qlim',[deg2rad(-5),deg2rad(85)]);
    L4 = Link('a',0,'d',0,'alpha',deg2rad(90),'offset',deg2rad(180),'qlim',[deg2rad(-90),deg2rad(90)]);

    self.model = SerialLink([L1 L2 L3 L4],'name','Dobot');
end
    
    
    
    
    % function outputArg = method1(obj,inputArg)
%     %METHOD1 Summary of this method goes here
%     %   Detailed explanation goes here
%     outputArg = obj.Property1 + inputArg;
% end
    end
end