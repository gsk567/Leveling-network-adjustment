clear;
clc;

fileDir = uigetfile({'*.txt';'*.asc'},'Open data file');
rowFile = dlmread(fileDir);

projectName = InputProjectData();

imageDir = uigetfile({'*.jpg';'*.jpeg';'*.bmp'},'Open image file with network schema');
mainImage = imread(imageDir);

amountFixedPoints = rowFile(1,1);
amountMeasurements = rowFile(1,2);
fixedPoints = rowFile(2:1+amountFixedPoints,1:2);
measurements = rowFile(2+amountFixedPoints:1+amountFixedPoints+amountMeasurements,1:4);

pointsArray = CreatePointsArray(measurements,fixedPoints);
measurementsArray = CreateMeasurementsArray(measurements,pointsArray);

network = Network(pointsArray,measurementsArray);
network.ComputePointsHeights();

networkAdjustment = NetworkAdjustment(network);
network.CreateGraph();
networkFigure = CreateNetworkGraph(network,mainImage);

reportDocument = ReportGenerator(networkAdjustment,projectName,networkFigure);
rptview(reportDocument.OutputPath);

clc;
disp('Computation successful!')
disp('Results are printed in folder Results')
