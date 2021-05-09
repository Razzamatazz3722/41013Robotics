classdef PingPongBall
    properties
        ballCount = 1;
        
        ball;
        
        %> Dimensions of the workspace in regard to the padoc size
        workspaceDimensions;    
    end
    
    properties (SetAccess = private)
        initialPositions;
    end
    
    methods
        
        function self = PingPongBall(ballCount)
            if 0 < nargin
                self.ballCount = ballCount;
            end
            
            self.workspaceDimensions = [-2, 2 ,-2, 2, 0, 2];
            
            for i = 1:self.ballCount
                self.ball{i} = self.GetBallModel(['ball',num2str(i)]);
                
                %Spawn Bricks
                %self.ball{1}.base = transl(0,0.4,0) * trotx(-90 * pi/180) * troty(pi/2);
                plot3d(self.ball{i},0,'workspace',self.workspaceDimensions,'view',[-30,30],'delay',0);
            end
            camlight;
        end  
    end
    
    methods (Static)
        % Get the PingPongBall model
      function model = GetBallModel(name)
            if nargin < 1
                name = 'ball';
            end
            [faceData,vertexData] = plyread('RedBall.ply','tri');
            L1 = Link('alpha',-pi/2,'a',0,'d',0.0,'offset',0);
            model = SerialLink(L1,'name',name);
            model.faces = {faceData,[]};
            vertexData(:,2) = vertexData(:,2) + 0.01;
            model.points = {vertexData * rotx(-pi/2),[]};

        end
    end
end  
    
    
