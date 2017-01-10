function measurementsArray = CreateMeasurementsArray(measurements,pointsArray)

    for i = 1:1:length(measurements)
       fromP = measurements(i,1);
       toP = measurements(i,2);
       deltaH = measurements(i,3);
       distance = measurements(i,4);
       fromPoint = findobj(pointsArray,'Number',fromP);
       toPoint = findobj(pointsArray,'Number',toP);
       measurementsArray(i,1) = HeightMeasurement(fromPoint,toPoint,deltaH,distance);      
    end

end

