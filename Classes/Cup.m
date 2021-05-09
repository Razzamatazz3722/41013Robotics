classdef Cup
    
    properties
        cupCount = 1;
        
        cup;
        
        %> Dimensions of the workspace in regard to the padoc size
        workspaceDimensions;    
    end
    
    properties (SetAccess = private)
        initialPositions;
    end
    
    methods
        
        function self = Cup(cupCount)
            if 0 < nargin
                self.cupCount = cupCount;
            end
            
            self.workspaceDimensions = [-2, 2 ,-2, 2, 0, 2];
            
            for i = 1:self.cupCount
                self.cup{i} = self.GetCupModel(['cup',num2str(i)]);
                
                %Spawn Bricks
                self.cup{1}.base = transl(0,0,0) * trotx(-90 * pi/180) * troty(pi/2);
                plot3d(self.cup{i},0,'workspace',self.workspaceDimensions,'view',[-30,30],'delay',0);
            end
            camlight;
        end  
    end
    
    methods (Static)
        % Get the PingPongcup model
      function model = GetCupModel(name)
            if nargin < 1
                name = 'cup';
            end
            [faceData,vertexData] = plyread('RedCupV2.ply','tri');
            L1 = Link('alpha',-pi/2,'a',0,'d',0.0,'offset',0);
            model = SerialLink(L1,'name',name);
            model.faces = {faceData,[]};
            vertexData(:,2) = vertexData(:,2) + 0.01;
            model.points = {vertexData * rotx(-pi/2),[]};

        end
    end
end  
    
    

