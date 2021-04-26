classdef Cup
    properties 
        units;
        
        model;
    end
    
    properties (SetAccess = private)
       initialPositions ;
    end
    
    methods
        
        function obj = Cup(position,name)
%             [ faceData, vertexData ] = plyread(['Brick.ply'],'tri');
%             L1 = Link('alpha',-pi/2,'a',0,'d',0.3,'offset',0)
%             obj.model = SerialLink(L1,'name',name)
%             obj.model.faces = {faceData,[]};
%             display("faces");
%             vertexData(:,2) = vertexData(:,2);
%             display("vertex");
%             obj.model.points = {vertexData * rotx(-pi/2),[]};
%             display("points");
%             obj.model.base = transl(position(1,1),position(1,2),position(1,3))*trotx(90,'deg')
%             display("base");
        end
        
    end
end

