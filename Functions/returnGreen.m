function greenObjects = returnGreen(objectList)
  %return the green objects in the list  
    initialise = 0;

    for(i=1:length(objectList))
       
        if(objectList(i).Colour == "green")
            if(initialise == 0)
                greenObjects(1,:) = objectList(i).Coordinates;
                initialise = 1;
            else
                greenObjects(end+1,:) = objectList(i).Coordinates;
            end
        end
        
    end
    
end