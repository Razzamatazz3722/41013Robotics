classdef Dobot
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = Dobot()
            
            L1 = Link('a',0,'d',0.08,'alpha',90,'qlim',[deg2rad(-90),deg2rad(90)])
            L2 = Link('a',deg2rad(130),'d',0,'alpha',0,'qlim',[0,deg2rad(85)])
            L3 = Link('a',deg2rad(160),'d',0,'alpha',0,'qlim',[deg2rad(-10),deg2rad(90)])
            L4 = Link('a',0,'d',0,'alpha',0,'qlim',[deg2rad(-90),deg2rad(90))
  
            
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

