function fig = CreateNetworkGraph(network,mainImage)

    coords = GetPointsCoordinates(network,mainImage);
    fig = figure;
    hold on
    gPlot = plot(network.Graph,'XData',coords(:,1),'YData',coords(:,2),'EdgeLabel',network.Graph.Edges.Weight);
    gPlot.MarkerSize = 6;
    gPlot.ArrowSize = 10;
    gPlot.LineWidth = 1;
    givenP = findobj(network.Points,'Given',true);
    nodes = table2array(network.Graph.Nodes);
    for i = 1:1:length(nodes)
       nodesI(i) = str2num(nodes{i}); 
    end

    for i = 1:1:length(givenP)
        indexP = find(nodesI == givenP(i).Number);
        scatter(coords(indexP,1),coords(indexP,2),12,'o','MarkerEdgeColor','r','MarkerFaceColor','r')
    end

    axis equal
    axis off
    hold off

end

