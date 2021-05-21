function blueObjects = returnBlue(objectList)
%return the blue objects in the list
    blueObjects(1,:) = objectList(1).Coordinates
    initialise = 0;
    for(i=1:length(objectList))
        
        if(objectList(i).Colour == "blue")
            if(initialise == 0)
                blueObjects(1,:) = objectList(i).Coordinates
                initialise = 1
            else
                blueObjects(end+1,:) = objectList(i).Coordinates
            end
        end
        
    end
    
    
    
end