function coords = GetPointsCoordinates(network,mainImage)
    nodes = table2array(network.Graph.Nodes);
    
    [imgHeight,imgWidth,~] = size(mainImage);
    fig = figure;
    hold on
    axis equal
    image([0,imgWidth],[imgHeight,0],mainImage);

    stepY = imgHeight/(length(nodes)+2);
    stepX = imgWidth/20;
    for i = 1:1:length(nodes)
        h(i) = impoint(gca,stepX,imgHeight-i*stepY);
        setString(h(i),nodes(i));
        setColor(h(i),'r');
    end
    
    
    for i = 1:1:length(h)
       pos = wait(h(i));
       coords(i,:) = h(i).getPosition(); 
       scatter(coords(i,1),coords(i,2),25,'filled','o','MarkerEdgeColor','y','MarkerFaceColor','y')
       text(coords(i,1),coords(i,2),nodes(i),'VerticalAlignment','bottom','HorizontalAlignment','right',...
           'Color','y','FontSize',14);
       delete(h(i));
    end
    hold off
    close(fig);

end

