function isCollision = CheckCollision(robot, sphereCenter, radius)
% function isCollision = CheckCollision(robot, sphereCenter, radius)

    pause(0.1)
    %Current end effector point
    tr = robot.fkine(robot.getpos);
    %calculates distance to the centre of the ball
    endEffectorToCenterDist = sqrt(sum((sphereCenter-tr(1:3,4)').^2));
    
    %added the 0.025 as a factor of safety to account of the end-effector
    %size
    if endEffectorToCenterDist <= radius + 0.025
        disp('Oh no a collision!');
         isCollision = 1;
    else
        disp(['SAFE: End effector to sphere centre distance (', num2str(endEffectorToCenterDist), 'm) is more than the sphere radius, ' num2str(radius), 'm']);
         isCollision = 0;
    end

end