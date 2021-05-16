%% Light Barriers Test:
clear; clc; clf;


%Plot a cow (this is the obstacle)
Cows = RobotCows(1);
Cows.cow{1,1}.base = transl(-1.8,-1.5,0);
animate(Cows.cow{1,1},0);

%Plots the laser for the light barrier
startLaser = [-2.2,-2.15,0.6];
endLaser = [-2.2,-1,0.6];
plot3([startLaser(1),endLaser(1)],[startLaser(2);endLaser(2)],[startLaser(3),endLaser(3)],'LineWidth',6);
    
base = Cows.cow{1,1}.base;
offset = 0.5;


display(['x + offset =',num2str(base(1,4) + offset)]); 
display(['start laser = ',startLaser(1,1)]); 
display(['x =',num2str(base(1,4) + offset)]); 
display(['start laser = ',startLaser(1,1)]);



%Determines if the cow has passed the threshold of the laser
% if (base(1,4) + offset >= startLaser(1,1)) & (base(1,4) <= endLaser(1,2)) & (base(2,4) + offset  >= startLaser(1,2))
%    %intersection
%    display('intersection');
% else
%     display('no intersection');
% end
if (base(1,4) >= startLaser(1,1) - offset) & ... % x > lineX
   (base(1,4) <=  startLaser(1,1) + offset)    
   (base(2,4) >= startLaser(1,2)) & ... % y between laser y's
   (base(2,4) <= endLaser(1,2))
   %intersection
   display('intersection');
else
    display('no intersection');
end

