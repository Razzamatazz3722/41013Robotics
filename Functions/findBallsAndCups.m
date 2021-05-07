function [cups, balls] = findBallsAndCups(allObjects,totalCups,totalBalls)
    % determines the cups and balls based on the total number of blobs vs
    % the total number of cups and balls. Is is an assumption that the
    % cups are larger than the balls and that no ball blobs coincide with
    % the cup blobsn of a same colour

    % sort all the objects by area
    T = struct2table(allObjects); % convert the struct array to a table
    sortedT = sortrows(T, 'Area', 'descend'); % sort the table by 'DOB'
    sortedObj = table2struct(sortedT); % change it back to struct array if necessary

        
    balls = sortedObj(1:totalCups);
    cups = sortedObj((totalCups+1):(totalCups+totalBalls));

end

