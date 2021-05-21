function qMat = GoGoal(robot, goalLocation, neutralQ, steps)
    goalTR = transl(goalLocation)*trotx(pi) %get transform of goal location (ball/cup)
    currentQ = robot.getpos(); %get current joint positions of dobot
    
%---checks where the goal location is and adjusts its inital angle guess---
    tempQ = neutralQ;
    if goalLocation(2) > 0.01 
        tempQ(1) = deg2rad(45);
    elseif goalLocation(2) < -0.01
        tempQ(1) = deg2rad(-45);
    end
    
    tempQ(2) = deg2rad(30);

    goalQ = robot.ikine(goalTR,tempQ,[1,1,1,0,0,0]);
    
%---Checking if the its within joint limits and adjusts accordingly---
    if goalQ(1)< deg2rad(-90)
        goalQ(1) = deg2rad(-90);
    elseif goalQ(1)> deg2rad(90)
        goalQ(1) = deg2rad(90);
    end
    
    if goalQ(2) < deg2rad(0)
        goalQ(2) = deg2rad(0);
    elseif goalQ(2) > deg2rad(80)
        goalQ(2) = deg2rad(80);
    end
    
    if goalQ(3) < deg2rad(-10)
        goalQ(3) = deg2rad(-10);
    elseif goalQ(3) > deg2rad(85)
        goalQ(3) = deg2rad(85);
    end
    
    if goalQ(4) < deg2rad(-90)
        goalQ(4) = deg2rad(-90);
    elseif goalQ(4) > deg2rad(90)
        goalQ(4) = deg2rad(90);
    end
%-----------------------------------------------------------------------
    actualTR = robot.fkine(goalQ);
    qMat = jtraj(currentQ,goalQ,steps);
    neutralQ;
end