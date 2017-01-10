classdef Point < handle

    properties
        Number;
        Height;
        Given;
        Known;
        ApproximatedHeights = [];
        LSQCorrection;
        RMS;
    end
    
    methods
        function obj = Point(number)
            obj.Number = number;
        end
        
        function ComputeHFromApprox(obj)
            if (obj.Given == false)
                uniqueApprox = unique(obj.ApproximatedHeights);
                obj.ApproximatedHeights = uniqueApprox;
                obj.Height = mean(obj.ApproximatedHeights); 
            end
        end
        
        function HeightCorrection(obj)
            obj.Height = obj.Height + obj.LSQCorrection;
        end
        
    end
    
end

