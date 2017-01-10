classdef HeightMeasurement < handle
    
    properties
        FromPoint;
        ToPoint;
        HeightDelta;
        DistanceKM;
        LSQResidual;
        CorrectedHeightDelta;
    end
    
    methods
        function obj = HeightMeasurement(fromPoint,toPoint,heightDelta,distanceKM)
            obj.FromPoint = fromPoint;
            obj.ToPoint = toPoint;
            obj.HeightDelta = heightDelta;
            obj.DistanceKM = distanceKM;
        end
        
        function ComputeApproxHeight(obj,point)
            if (isempty(point.Height))
                return;
            end
            
            if (point.Number == obj.FromPoint.Number)
                currentH = point.Height + obj.HeightDelta;
                obj.ToPoint.ApproximatedHeights = [obj.ToPoint.ApproximatedHeights;currentH];
                obj.ToPoint.Known = true;
                obj.ToPoint.ComputeHFromApprox();
            elseif (point.Number == obj.ToPoint.Number)
                currentH = point.Height - obj.HeightDelta;
            	obj.FromPoint.ApproximatedHeights = [obj.FromPoint.ApproximatedHeights;currentH];
                obj.FromPoint.Known = true;
                obj.FromPoint.ComputeHFromApprox();
            end

        end
        
    end
    
end

