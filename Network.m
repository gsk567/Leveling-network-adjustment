classdef Network < handle

    properties
        Points;
        Measurements;
        Graph;
    end
    
    methods
        function obj = Network(points,measurements)
            obj.Points = points;
            obj.Measurements = measurements;
        end
        
        function neighbors = FindNeighborsMeasurements(obj,point)
            j = 1;
            for i = 1:1:length(obj.Measurements)
                if (obj.Measurements(i).FromPoint.Number == point.Number || ...
                        obj.Measurements(i).ToPoint.Number == point.Number)
                    neighbors(j,1) = obj.Measurements(i);
                    j = j + 1;
                end
            end
        
        end
    
        function ComputePointsHeights(obj)
        	knownPoints = findobj(obj.Points,'Known',true);
            while (length(knownPoints) ~= length(obj.Points))
                for i = 1:1:length(obj.Points)
                    currentNeighbors = FindNeighborsMeasurements(obj,obj.Points(i));
                    for k = 1:1:length(currentNeighbors)
                    	currentNeighbors(k).ComputeApproxHeight(obj.Points(i));
                    end
                end
                knownPoints = findobj(obj.Points,'Known',true);
            end
        end
        
        function CreateGraph(obj)
            for i = 1:1:length(obj.Measurements)
                s{i} = num2str(obj.Measurements(i).FromPoint.Number);
                t{i} = num2str(obj.Measurements(i).ToPoint.Number);
                weights(i) = obj.Measurements(i).CorrectedHeightDelta;
            end
           obj.Graph = digraph(s,t,weights);
        end
        
    end
end
