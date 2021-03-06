function demoLightBarrier(bot,eStop)
%% Light Barriers Test:
%clear; clc;

%% Robot Initialisation
% clearvars
% rosshutdown
% rosinit('10.42.0.1');
% %%
% bot = OtherDobotFunctions();
% pause(5);
%%
%bot.setMode(4);
%Plot a cow (this is the obstacle)
Cows = RobotCows(1);
Cows.cow{1,1}.base = transl(-10,-1.5,0);
animate(Cows.cow{1,1},0);

%Plots the laser for the light barrier
startLaser = [-2.2,-2.15,0.6];
endLaser = [-2.2,-1,0.6];
plot3([startLaser(1),endLaser(1)],[startLaser(2);endLaser(2)],[startLaser(3),endLaser(3)],'LineWidth',6);

base = Cows.cow{1,1}.base;
offset = 0.5;

while(1)
    Cows.cow{1,1}.base = Cows.cow{1,1}.base * transl(0.3,0,0);
    animate(Cows.cow{1,1},0);
    base = Cows.cow{1,1}.base
    
    result = checkForIntruder(startLaser, endLaser, base, offset, 1);
    
    if result == 1
        display('Intersection');
        eStop.Value = true;
        bot.eStop();
        return;
    else
        display('move to random point');
        %pick a random point
        %joint 1
        j1 = 0.5+(-0.5-0.5).*rand;
        %joint 2
        j2 = 0.8+(0-0.8).*rand;
        %joint 3
        j3 = 0.7+(-0.2-0.7).*rand;
        %joint 4
        j4 = 0;
        
        bot.setTargetJointState([j1,j2,j3,j4]);   
    end
    pause(0.5)
end



function result = checkForIntruder(startLaser, endLaser, base, offset, debug)

    if(debug==1)% print messages
        display(['x + offset =',num2str(base(1,4) + offset)])
        display(['start laser = ',startLaser(1,1)]);
        display(['x =',num2str(base(1,4) + offset)]);
        display(['start laser = ',startLaser(1,1)]);
    end

    % if object is between lasers, return 1, if not return 0
    if (base(1,4) >= startLaser(1,1) - offset) & ... % x > lineX
            (base(1,4) <=  startLaser(1,1) + offset)
        (base(2,4) >= startLaser(1,2)) & ... % y between laser y's
            (base(2,4) <= endLaser(1,2))

        result = 1;
    else
        result = 0;
    end

end
end



