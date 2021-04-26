classdef Dobot
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = Dobot()
            
            L1 = Link('a',0,'d',0.1519,'alpha',pi/2,'qlim',[-2*pi,2*pi])
            L2 = Link('a',-0.24365,'d',0,'alpha',0,'qlim',[-2*pi,2*pi])
            L3 = Link('a',-0.21325,'d',0,'alpha',0,'qlim',[-2*pi,2*pi])
            L4 = Link('a',0,'d',0.11235,'alpha',pi/2,'qlim',[-2*pi,2*pi])
            L5 = Link('a',0,'d',0.08535,'alpha',-pi/2,'qlim',[-2*pi,2*pi])
            L6 = Link('a',0,'d',0.0819,'alpha',0,'qlim',[])
            
            obj.model = SerialLink([L1 L2 L3 L4 L5 L6],'name','UR3'); 
            
            q = zeros(1,6)
            obj.model.plot(q,'fps',25,'workspace',obj.workspace,'scale',0.5);
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

