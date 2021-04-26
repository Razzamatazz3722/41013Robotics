function Workspace()

%Set's the size of the workspace
workspace = [-2.3 2.3 -2.3 2.3 0 2.3];
scale = 0.5;

%Set's the view angle of the workspace
view([-30,30])

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
PlaceObject('FenceA.ply', [-1.5,2.3,0.01]);
PlaceObject('FenceB.ply', [-0.9,-2,0.01]);

end
