function document = ReportGenerator(networkAdjustment,nameOfProject,fig)
    
    givenPoints = findobj(networkAdjustment.Network.Points,'Given',true);
    newPoints = findobj(networkAdjustment.Network.Points,'Given',false);
    measurements = networkAdjustment.Network.Measurements;
    amountMeasurements = length(measurements);
    amountGivenPoints = length(givenPoints);
    amountNewPoints = length(newPoints);
    amountOvermeasurements = amountMeasurements - amountNewPoints;
    
    mkdir('Results');
    import mlreportgen.dom.*;
    document = Document('Results/Adjustment Report','docx');
    open(document);

    title = Paragraph('ADJUSTMENT REPORT');
    title.Style = {LineSpacing(1)};
    title.FontSize = '24';
    title.HAlign = 'center';
    append(document,title);

    projectTitle = Paragraph('1.Input Data');
    projectTitle.Style = {LineSpacing(1)};
    projectTitle.FontSize = '18';
    projectTitle.HAlign = 'left';
    append(document,projectTitle);
    
    currentRow = Paragraph([' • amount measurements (n): ',num2str(amountMeasurements)]);
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph([' • amount given points: ',num2str(amountGivenPoints)]);
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph([' • amount new points (k): ',num2str(amountNewPoints)]);
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph([' • amount overmeasurements (r = n - k): ',num2str(amountOvermeasurements)]);
    currentRow.Style = {LineSpacing(2)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('2.Points');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '18';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('2.1.Given Points');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(givenPoints)
        lineSpacing = 1;
        if (i == length(givenPoints))
            lineSpacing = 2;
        end
        currentPoint = givenPoints(i);
        currentText = sprintf(' • point %d: H%d = %.3fm.',currentPoint.Number,currentPoint.Number,currentPoint.Height);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('2.2.New points');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);

    for i = 1:1:length(newPoints)
        lineSpacing = 1;
        if (i == length(newPoints))
            lineSpacing = 2;
        end
        currentPoint = newPoints(i);
        currentText = sprintf(' • point %d',currentPoint.Number);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('3.Measurements');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '18';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(measurements)
        lineSpacing = 1;
        if (i == length(measurements))
            lineSpacing = 2;
        end

        currentText = sprintf(' • measurement %d: h%d = %.3fm.',i,i,measurements(i).HeightDelta);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('4.Equations');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '18';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('4.1.Common type');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(measurements)
        lineSpacing = 1;
        if (i == length(measurements))
            lineSpacing = 2;
        end

        currentText = sprintf(' • h%d = H%d - H%d',i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('4.2.Extended form');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('* hi = hi` + vi');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('* Hi = Hi° + dHi');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('---');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(measurements)
        lineSpacing = 1;
        if (i == length(measurements))
            lineSpacing = 1;
        end
        if (measurements(i).ToPoint.Given == false && measurements(i).FromPoint.Given == false)
            currentText = sprintf(' • h`%d + v%d = (H%d° + dH%d) - (H%d° + dH%d) where f%d = H%d° - H%d° - h`%d = h°%d - h`%d',...
                i,i,measurements(i).ToPoint.Number,measurements(i).ToPoint.Number,...
                measurements(i).FromPoint.Number,measurements(i).FromPoint.Number,...
                i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number,i,i,i);
        elseif (measurements(i).ToPoint.Given == false && measurements(i).FromPoint.Given == true)
            currentText = sprintf(' • h`%d + v%d = (H%d° + dH%d) - H%d where f%d = H%d° - H%d - h`%d = h°%d - h`%d',...
                i,i,measurements(i).ToPoint.Number,measurements(i).ToPoint.Number,...
                measurements(i).FromPoint.Number,...
                i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number,i,i,i);            
        elseif (measurements(i).ToPoint.Given == true && measurements(i).FromPoint.Given == false)
            currentText = sprintf(' • h`%d + v%d = H%d - (H%d° + dH%d) where f%d = H%d - H%d° - h`%d = h°%d - h`%d',...
                i,i,measurements(i).ToPoint.Number,...
                measurements(i).FromPoint.Number,measurements(i).FromPoint.Number,...
                i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number,i,i,i);            
        elseif (measurements(i).ToPoint.Given == true && measurements(i).FromPoint.Given == true)
            currentText = sprintf(' • h`%d + v%d = H%d - H%d where f%d = H%d - H%d - h`%d = h°%d - h`%d',...
                i,i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number,...
                i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number,i,i,i);               
        end
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('---');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(measurements)
        lineSpacing = 1;
        if (i == length(measurements))
            lineSpacing = 1;
        end
        if (measurements(i).ToPoint.Given == false && measurements(i).FromPoint.Given == false)
            currentText = sprintf(' • %.3f + v%d = (%.3f + dH%d) - (%.3f + dH%d) ==> f%d = %.3f - %.3f - %.3f = %.2fmm.',...
                measurements(i).HeightDelta,i,mean(measurements(i).ToPoint.ApproximatedHeights),measurements(i).ToPoint.Number,...
                mean(measurements(i).FromPoint.ApproximatedHeights),measurements(i).FromPoint.Number,...
                i,mean(measurements(i).ToPoint.ApproximatedHeights),mean(measurements(i).FromPoint.ApproximatedHeights),...
                measurements(i).HeightDelta,(mean(measurements(i).ToPoint.ApproximatedHeights)-mean(measurements(i).FromPoint.ApproximatedHeights)-...
                measurements(i).HeightDelta)*1000);
        elseif (measurements(i).ToPoint.Given == false && measurements(i).FromPoint.Given == true)
            currentText = sprintf(' • %.3f + v%d = (%.3f + dH%d) - %.3f ==> f%d = %.3f - %.3f - %.3f = %.2fmm.',...
                measurements(i).HeightDelta,i,mean(measurements(i).ToPoint.ApproximatedHeights),i,measurements(i).FromPoint.Height,...
                i,mean(measurements(i).ToPoint.ApproximatedHeights),measurements(i).FromPoint.Height,measurements(i).HeightDelta,...
                (mean(measurements(i).ToPoint.ApproximatedHeights)-measurements(i).FromPoint.Height-measurements(i).HeightDelta)*1000);            
        elseif (measurements(i).ToPoint.Given == true && measurements(i).FromPoint.Given == false)
            currentText = sprintf(' • %.3f + v%d = %.3f - (%.3f + dH%d) ==> f%d = %.3f - %.3f - %.3f = %.2fmm.',...
                measurements(i).HeightDelta,i,measurements(i).ToPoint.Height,mean(measurements(i).FromPoint.ApproximatedHeights),i,...
                i,measurements(i).ToPoint.Height,mean(measurements(i).FromPoint.ApproximatedHeights),measurements(i).HeightDelta,...
                (measurements(i).ToPoint.Height-mean(measurements(i).FromPoint.ApproximatedHeights)-measurements(i).HeightDelta)*1000);            
        elseif (measurements(i).ToPoint.Given == true && measurements(i).FromPoint.Given == true)
            currentText = sprintf(' • %.3f + v%d = %.3f - %.3f ==> f%d = %.3f - %.3f - %.3f = %.2fmm.',...
                measurements(i).HeightDelta,i,measurements(i).ToPoint.Height,measurements(i).FromPoint.Height,...
                i,measurements(i).ToPoint.Height,measurements(i).FromPoint.Height,measurements(i).HeightDelta,...
                (measurements(i).ToPoint.Height-measurements(i).FromPoint.Height-measurements(i).HeightDelta)*1000);               
        end
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '14';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('---');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(measurements)
        lineSpacing = 1;
        if (i == length(measurements))
            lineSpacing = 2;
        end
        if (measurements(i).ToPoint.Given == false && measurements(i).FromPoint.Given == false)
            currentText = sprintf(' • v%d = dH%d - dH%d + f%d, f%d = %.2fmm.',...
                i,measurements(i).ToPoint.Number,measurements(i).FromPoint.Number,i,...
                i,(mean(measurements(i).ToPoint.ApproximatedHeights)-mean(measurements(i).FromPoint.ApproximatedHeights)-...
                    measurements(i).HeightDelta)*1000);
        elseif (measurements(i).ToPoint.Given == false && measurements(i).FromPoint.Given == true)
            currentText = sprintf(' • v%d = dH%d + f%d, f%d = %.2fmm.',...
                i,measurements(i).ToPoint.Number,i,i,...
                (mean(measurements(i).ToPoint.ApproximatedHeights)-measurements(i).FromPoint.Height-measurements(i).HeightDelta)*1000);            
        elseif (measurements(i).ToPoint.Given == true && measurements(i).FromPoint.Given == false)
            currentText = sprintf(' • v%d = -dH%d + f%d, f%d = %.2fmm.',...
                i,measurements(i).FromPoint.Number,i,i,...
                (measurements(i).ToPoint.Height-mean(measurements(i).FromPoint.ApproximatedHeights)-measurements(i).HeightDelta)*1000);            
        elseif (measurements(i).ToPoint.Given == true && measurements(i).FromPoint.Given == true)
            currentText = sprintf(' • v%d = f%d, f%d = %.2fmm.',...
                i,i,i,...
                (measurements(i).ToPoint.Height-measurements(i).FromPoint.Height-measurements(i).HeightDelta)*1000);               
        end
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('5.Matrices');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '18';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.1.Configuration Matrix (A)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    confMatrix = networkAdjustment.ConfigurationMatrix;
    [rowsConf,colConf] = size(confMatrix);
    indexes = networkAdjustment.NewPointsIndexes;

    for i = 1:1:length(indexes)
        strC = sprintf('dH%d',indexes(i));
        strConfMatrix{1,i} = strC;
    end
    
    for i = 1:1:rowsConf
       for j = 1:1:colConf
           stEl = sprintf('%d',confMatrix(i,j));
           strConfMatrix{i+1,j} = stEl;
       end
    end
    
    tableConf = append(document,strConfMatrix);
    tableConf.Style = {RowHeight('0.2in')};
    tableConf.Border = 'single';
    tableConf.ColSep = 'single';
    tableConf.RowSep = 'single';
    tableConf.HAlign = 'center';
    tableConf.TableEntriesHAlign = 'center';
    tableConf.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.2.Free Members Matrix (f)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    freeMembersMatrix = networkAdjustment.FreeMembersMatrix;
    
    for i = 1:1:length(freeMembersMatrix)
    	stEl = sprintf('%.2f',freeMembersMatrix(i)*1000);
    	strFMMatrix{i,1} = stEl;
    end
    
    tableFreeM = append(document,strFMMatrix);
    tableFreeM.Style = {RowHeight('0.2in')};
    tableFreeM.Border = 'single';
    tableFreeM.ColSep = 'single';
    tableFreeM.RowSep = 'single';
    tableFreeM.HAlign = 'center';
    tableFreeM.TableEntriesHAlign = 'center';
    tableFreeM.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.3.Weight Matrix (P)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('* pi = 1/Si[km]');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    wMatrix = networkAdjustment.WeightMatrix;
    [rowsW,colW] = size(wMatrix);

    for i = 1:1:rowsW
       for j = 1:1:colW
           stEl = sprintf('%.4f',wMatrix(i,j));
           strWMatrix{i,j} = stEl;
       end
    end
    
    tableW = append(document,strWMatrix);
    tableW.Style = {RowHeight('0.2in')};
    tableW.Border = 'single';
    tableW.ColSep = 'single';
    tableW.RowSep = 'single';
    tableW.HAlign = 'center';
    tableW.TableEntriesHAlign = 'center';
    tableW.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.4.Normal Matrix (N = A*PA)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    normalMatrix = networkAdjustment.NormalMatrix;
    [rowsN,colN] = size(normalMatrix);
    indexes = networkAdjustment.NewPointsIndexes;

    for i = 1:1:length(indexes)
        strC = sprintf('dH%d',indexes(i));
        strNMatrix{1,i} = strC;
    end
    
    for i = 1:1:rowsN
       for j = 1:1:colN
           stEl = sprintf('%.4f',normalMatrix(i,j));
           strNMatrix{i+1,j} = stEl;
       end
    end
    
    tableN = append(document,strNMatrix);
    tableN.Style = {RowHeight('0.2in')};
    tableN.Border = 'single';
    tableN.ColSep = 'single';
    tableN.RowSep = 'single';
    tableN.HAlign = 'center';
    tableN.TableEntriesHAlign = 'center';
    tableN.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.5.Normal Matrix Free Members (F = A*Pf) // f[m]');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    normalFMatrix = networkAdjustment.FreeMembersNormalMatrix;

	for i = 1:1:length(normalFMatrix)
        stEl = sprintf('%.4f',normalFMatrix(i));
        strNFMatrix{i,1} = stEl;
	end
    
    tableNF = append(document,strNFMatrix);
    tableNF.Style = {RowHeight('0.2in')};
    tableNF.Border = 'single';
    tableNF.ColSep = 'single';
    tableNF.RowSep = 'single';
    tableNF.HAlign = 'center';
    tableNF.TableEntriesHAlign = 'center';
    tableNF.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.6.Reverse Matrix (Q = N^(-1))');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    reverseMatrix = networkAdjustment.ReverseMatrix;
    [rowsQ,colQ] = size(reverseMatrix);
    indexes = networkAdjustment.NewPointsIndexes;

    for i = 1:1:length(indexes)
        strC = sprintf('dH%d',indexes(i));
        strQMatrix{1,i} = strC;
    end
    
    for i = 1:1:rowsQ
       for j = 1:1:colQ
           stEl = sprintf('%.4f',reverseMatrix(i,j));
           strQMatrix{i+1,j} = stEl;
       end
    end
    
    tableQ = append(document,strQMatrix);
    tableQ.Style = {RowHeight('0.2in')};
    tableQ.Border = 'single';
    tableQ.ColSep = 'single';
    tableQ.RowSep = 'single';
    tableQ.HAlign = 'center';
    tableQ.TableEntriesHAlign = 'center';
    tableQ.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.7.Corrections Matrix (dH = -QF)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    corrFMatrix = networkAdjustment.CorrectionsMatrix;

	for i = 1:1:length(corrFMatrix)
        stEl = sprintf('%.4f',corrFMatrix(i));
        strCorrMatrix{i,1} = stEl;
	end
    
    tableCorr = append(document,strCorrMatrix);
    tableCorr.Style = {RowHeight('0.2in')};
    tableCorr.Border = 'single';
    tableCorr.ColSep = 'single';
    tableCorr.RowSep = 'single';
    tableCorr.HAlign = 'center';
    tableCorr.TableEntriesHAlign = 'center';
    tableCorr.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('5.8.Residuals Matrix (V = AdH + f)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    resMatrix = networkAdjustment.ResidualsMatrix;

	for i = 1:1:length(resMatrix)
        stEl = sprintf('%.4f',resMatrix(i));
        strResMatrix{i,1} = stEl;
	end
    
    tableRes = append(document,strResMatrix);
    tableRes.Style = {RowHeight('0.2in')};
    tableRes.Border = 'single';
    tableRes.ColSep = 'single';
    tableRes.RowSep = 'single';
    tableRes.HAlign = 'center';
    tableRes.TableEntriesHAlign = 'center';
    tableRes.TableEntriesVAlign = 'middle';
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('6.Results and Accuracy Evaluation');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '18';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('6.1.Results');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('6.1.1.Corrected Measurements');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(measurements)
        lineSpacing = 1;
        if (i == length(measurements))
            lineSpacing = 2;
        end

        currentText = sprintf(' • h%d = h`%d + v%d = %.4f + (%.4f) = %.4fm.',i,i,i,measurements(i).HeightDelta,...
            measurements(i).LSQResidual,measurements(i).CorrectedHeightDelta);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('6.1.2.Corrected Heights');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(newPoints)
        lineSpacing = 1;
        if (i == length(newPoints))
            lineSpacing = 2;
        end

        currentText = sprintf(' • H%d = H%d° + dH%d = %.4f + (%.4f) = %.4fm.',newPoints(i).Number,newPoints(i).Number,...
            newPoints(i).Number,mean(newPoints(i).ApproximatedHeights),newPoints(i).LSQCorrection,newPoints(i).Height);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    currentRow = Paragraph('6.2.Accuracy Evaluation');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('6.2.1.Root Mean Square with Weight 1 (RMSW1)');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    strRMS = sprintf('%.2fmm',networkAdjustment.AccuracyEvaluation*1000);
    currentRow = Paragraph(['* RMSW1 = (V*PV/r)^(1/2) => ',strRMS]);
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph(' ');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '16';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    currentRow = Paragraph('6.2.2.Heights Root Mean Squares');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '17';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    for i = 1:1:length(newPoints)
        lineSpacing = 1;
        if (i == length(newPoints))
            lineSpacing = 2;
        end
        indexes = networkAdjustment.NewPointsIndexes;
        foundIndex = find(indexes==newPoints(i).Number);
        
        currentText = sprintf(' • mH%d = RMSW1*(Q(%d,%d)^(1/2)) = %.2fmm.',newPoints(i).Number,foundIndex,foundIndex,...
            newPoints(i).RMS*1000);
    	currentRow = Paragraph(currentText);
        currentRow.Style = {LineSpacing(lineSpacing)};
        currentRow.FontSize = '16';
        currentRow.HAlign = 'left';
        append(document,currentRow);    
    end
    
    br = PageBreak();
    append(document,br);
    currentRow = Paragraph('7.Network schema');
    currentRow.Style = {LineSpacing(1)};
    currentRow.FontSize = '18';
    currentRow.HAlign = 'left';
    append(document,currentRow);
    
    figureFileName = ['Results/',nameOfProject,'_figure'];
    print(fig,figureFileName,'-djpeg');
    
    figImage = Image([figureFileName,'.jpg']);
    figImage.Style = {ScaleToFit};
    append(document,figImage);
    close(document);

end

