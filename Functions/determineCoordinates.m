function [newObjects] = determineCoordinates(objects,cameraParameters,cameraHeight,objectHeight)
    newObjects = objects;
    
    %camera calibration matrix K
    fx = cameraParameters.FocalLength(1);
    fy = cameraParameters.FocalLength(2);
    cx = cameraParameters.PrincipalPoint(1);
    cy = cameraParameters.PrincipalPoint(2);

    k = [fx,0,cx;0,fy,cy;0,0,1];
    
    tmpCoord = [];
    for(i=1:length(newObjects))
        z = cameraHeight-objectHeight;
        UZ = newObjects(i).Centroid(1) * z;
        VZ = newObjects(i).Centroid(2) * z;
        Z = z;

        pixel_coordinates = [UZ; VZ; Z];

        K_inverse = inv(k);

        world_coord = (K_inverse * pixel_coordinates)
        
        C = num2cell(world_coord,1);
        [newObjects(i).Coordinates] = deal(C{:});
    end
    
end

