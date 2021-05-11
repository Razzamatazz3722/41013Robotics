function result = dobotSafetyStatus(safetyStatusMessage)
    %returns 1 if there is an error or 0 if there is no error
    
    safetyStatusSubscriber = rossubscriber(safetyStatusMessage);
    pause(2); %Allow some time for MATLAB to start the subscriber
    currentSafetyStatus = safetyStatusSubscriber.LatestMessage.Data;

    if(currentSafetyStatus == 0)
        display("DOBOT STATUS: INVALID");
        result = 1;
    elseif(currentSafetyStatus == 1)
        display("DOBOT STATUS: DISCONNECTED");
        result = 1;
    elseif(currentSafetyStatus == 2)
        display("DOBOT STATUS: INITIALISING");
        result = 1;
    elseif(currentSafetyStatus == 3)
        display("DOBOT STATUS: ESTOPPED");
        result = 1;
    elseif(currentSafetyStatus == 4)
        display("DOBOT STATUS: OPERATIONAL");
        result = 0;
    elseif(currentSafetyStatus == 5)
        display("DOBOT STATUS: PAUSED");
        result = 1;
    elseif(currentSafetyStatus == 6)
        display("DOBOT STATUS: STOPPED");
        result = 1;
    end
end

