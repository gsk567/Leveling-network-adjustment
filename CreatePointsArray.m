function points = CreatePointsArray(measurements, fixedPoints)
    
    uniquePointNumbers = unique(measurements(:,1:2));
    
    for i = 1:1:length(uniquePointNumbers)
    	points(i,1) = Point(uniquePointNumbers(i));
        indexAtFixed = find(fixedPoints(:,1) == uniquePointNumbers(i));
        points(i,1).Given = false;
        points(i,1).Known = false;
        if (~isempty(indexAtFixed))
            points(i,1).Height = fixedPoints(indexAtFixed,2);
            points(i,1).Given = true;
            points(i,1).ApproximatedHeights = fixedPoints(indexAtFixed,2);
            points(i,1).Known = true;
        end 
    end

end

