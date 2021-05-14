function Workspace()

%Set's the size of the workspace
workspace = [-2.3 2.3 -2.3 2.3 0 2.3];
scale = 0.5;

%Set's the view angle of the workspace
view([-36,44])

hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');

%Floor Surface
surf([-2.3,-2.3;2.3,2.3],[-2.3,2.3;-2.3,2.3],[0.01,0.01;0.01,0.01],...
    'CData',imread('Marble.jpeg'),'FaceColor','texturemap');

%Wall on ZX plane
surf([2.3,2.3;-2.3,-2.3],[2.3,2.3;2.3,2.3],[2.3,0.01;2.3,0.01],...
    'CData',imread('Wall.jpeg'),'FaceColor','texturemap');

 %Wall on ZY plane
surf([2.3,2.3;2.3,2.3],[-2.3,-2.3;2.3,2.3],[2.3,0.01;2.3,0.01],...
    'CData',imread('Wall.jpeg'),'FaceColor','texturemap');

%Import my Safety Features
PlaceObject('FenceA.ply', [-2.1,2.3,0.01]);
PlaceObject('FenceB.ply', [-1.9,-2,0.01]);
PlaceObject('Table.ply', [0,0,0.01]);
PlaceObject('FireExtinguisher.ply', [2,2,0.01]);
PlaceObject('FirstAidKit.ply', [-1.8,2,0.01]);
PlaceObject('E-Stop.ply', [-1,-0.5,0.75]);
PlaceObject('RedBall.ply', [-0.5,-0.15,0.75]);
PlaceObject('GreenBall.ply', [-0.5,0,0.75]);
PlaceObject('BlueBall.ply', [-0.5,0.15,0.75]);
PlaceObject('RedCupV2.ply', [0,0,0.75]);
PlaceObject('BlueCupV2.ply', [0,0.15,0.75]);
PlaceObject('GreenCupV2.ply', [0,-0.15,0.75]);
end
