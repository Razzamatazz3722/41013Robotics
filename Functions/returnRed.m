function redObjects = returnRed(objectList)
    
    initialise = 0;
    for(i=1:length(objectList))
       
        if(objectList(i).Colour == "red")
            if(initialise == 0)
                redObjects(1,:) = objectList(i).Coordinates;
                initialise = 1;
            else
                redObjects(end+1,:) = objectList(i).Coordinates;
            end
        end
        
    end
    
end

