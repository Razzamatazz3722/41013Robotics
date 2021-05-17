function demoCollision(dobot, bot, tableHeight, button, type)
 
%% Create 1-link robot
%dobot = Dobot().model; 
q = zeros(1,4)
hold on;
%% Create sphere
sphereCenter = [0.1,0.14,0.25+tableHeight];
radius = 0.035;
[X,Y,Z] = sphere(20);
X = X * radius + sphereCenter(1);
Y = Y * radius + sphereCenter(2);
Z = Z * radius + sphereCenter(3);

%% Plot it
% Plot point cloud
points = [X(:),Y(:),Z(:)];
spherePc_h = plot3(points(:,1),points(:,2),points(:,3),'r.');
delete (spherePc_h)

% % Or a triangle mesh
tri = delaunay(X,Y,Z);
sphereTri_h = trimesh(tri,X,Y,Z);
drawnow();
view(3)
axis equal

%% Move Robot
for q1 = 0:pi/180:pi/2
    q(1) = q1;
    if type == "sim"
        dobot.animate(q);
        drawnow();
    elseif type == "real"
        bot.setTargetJointState(q);
        dobot.animate(q);
        drawnow();
    end
    isCollision = CollisionCheck(dobot,sphereCenter,radius);
    if isCollision == 1
        if type == "sim"
            disp('UNSAFE: Robot stopped');
            button.Value = true;
            break;
        elseif type == "real"
            disp('UNSAFE: Robot stopped');
            bot.eStop();
            button.Value = true;
            break;
        end
    end
end

end
