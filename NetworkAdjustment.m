classdef NetworkAdjustment < handle

    properties
       Network;
       ConfigurationMatrix;
       FreeMembersMatrix;
       WeightMatrix;
       NormalMatrix;
       FreeMembersNormalMatrix;
       ReverseMatrix;
       CorrectionsMatrix;
       ResidualsMatrix;
       NewPointsIndexes;
       AccuracyEvaluation;
    end
    
    methods
        function obj = NetworkAdjustment(network)
           obj.Network = network; 
           ComputeConfigurationMatrix(obj);
           ComputeFreeMembersMatrix(obj);
           ComputeWeigthMatrix(obj);
           obj.NormalMatrix = (obj.ConfigurationMatrix')*(obj.WeightMatrix)*(obj.ConfigurationMatrix);
           obj.FreeMembersNormalMatrix = (obj.ConfigurationMatrix')*(obj.WeightMatrix)*(obj.FreeMembersMatrix);
           obj.ReverseMatrix = inv(obj.NormalMatrix);
           obj.CorrectionsMatrix = -obj.ReverseMatrix*obj.FreeMembersNormalMatrix;
           obj.ResidualsMatrix = obj.ConfigurationMatrix*obj.CorrectionsMatrix + obj.FreeMembersMatrix;
           obj.AccuracyEvaluation = sqrt((obj.ResidualsMatrix'*obj.WeightMatrix*obj.ResidualsMatrix)/ ...
                (length(obj.Network.Measurements)-length(obj.NewPointsIndexes)));
           
           
           SetCorrectionsToHeights(obj);
           SetResidualsToMeasurements(obj);
        end
        
        function ComputeConfigurationMatrix(obj)
            newPoints = findobj(obj.Network.Points,'Given',false);
            measurements = obj.Network.Measurements;
            for i = 1:1:length(newPoints)
                pointsIndexes(i,1) = newPoints(i).Number;
            end
            obj.NewPointsIndexes = pointsIndexes;
            
            
            obj.ConfigurationMatrix = zeros(length(measurements),length(newPoints));
            for i = 1:1:length(measurements)
                for j = 1:1:length(pointsIndexes)
                    currentIndexF = find(pointsIndexes == measurements(i).FromPoint.Number);
                    currentIndexT = find(pointsIndexes == measurements(i).ToPoint.Number);
                    if (currentIndexF ~= 0)
                        obj.ConfigurationMatrix(i,currentIndexF) = -1;
                    end
                    if (currentIndexT ~= 0)
                       obj.ConfigurationMatrix(i,currentIndexT) = 1;
                    end
                end
            end
            
        end
        
        function ComputeFreeMembersMatrix(obj)
          
            measurements = obj.Network.Measurements;
            for i = 1:1:length(measurements)
                approximatedDeltaH(i,1) = measurements(i).ToPoint.Height - measurements(i).FromPoint.Height;
                measuredDeltaH(i,1) = measurements(i).HeightDelta;
            end
            obj.FreeMembersMatrix = approximatedDeltaH - measuredDeltaH;
   
        end
        
        function ComputeWeigthMatrix(obj)
            measurements = obj.Network.Measurements;
            
            for i = 1:1:length(measurements)
                weights(i,1) = 1/measurements(i).DistanceKM;
            end
            obj.WeightMatrix = diag(weights);
            
        end
        
        function SetCorrectionsToHeights(obj)
            for i = 1:1:length(obj.Network.Points)
                if (obj.Network.Points(i).Given == false)
                    indexAtMatrix = find(obj.NewPointsIndexes == obj.Network.Points(i).Number);
                    obj.Network.Points(i).LSQCorrection = obj.CorrectionsMatrix(indexAtMatrix);
                    obj.Network.Points(i).HeightCorrection();
                    obj.Network.Points(i).RMS = obj.AccuracyEvaluation*sqrt(obj.ReverseMatrix(indexAtMatrix,indexAtMatrix));
                end
            end 
        end
        
        function SetResidualsToMeasurements(obj)
        	for i = 1:1:length(obj.Network.Measurements)
               obj.Network.Measurements(i).LSQResidual = obj.ResidualsMatrix(i);
               obj.Network.Measurements(i).CorrectedHeightDelta = ...
                   obj.Network.Measurements(i).HeightDelta + obj.Network.Measurements(i).LSQResidual;
        	end 
        end
            
    end
    
end

