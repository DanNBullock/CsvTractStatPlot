function bsc_genCSVfromStatMat(statMatPath)
%bsc_genCSVfromStatMat(statMatPath)
%bypass function for generation of csv stat structures.  Use it to make a
%csv output from a .mat tract stat input
%
%  Inputs:
%  statMatPath:  path to the tractomeResultStruc that one desires to
%  generate a csv for
%
%  Outputs:  None, its just going to save down the csv in the same
%  directory as the input .mat.  This is also why it is important to pass a
%  path and not an object
%
%  Note:  if you would like to augment the csv in the future, just keep
%  adding colums to the csv from index 24 on.  Be sure to update the wbfg
%  structure, the fieldnames, and the fullFieldNames.  Actually fieldnames
%  may actually be unsused, as this was an attempt at automating things,
%  but it seems that that currently hasn't been implimented
%
%  Dan Bullock, hastily, 10/5/2019  

load(statMatPath);
[fpath, ~, ~]=fileparts(statMatPath);
savePath=fpath;

results.WBFG;


tableArray{1,1}='wbfg';
tableArray{1,2}=results.WBFG.stream_count;
tableArray{1,3}=results.WBFG.volume;
tableArray{1,4}=results.WBFG.avg_stream_length;
tableArray{1,5}=results.WBFG.stream_length_stdev;
tableArray{1,6}=results.WBFG.avgFullDisp;
tableArray{1,7}=results.WBFG.stDevFullDisp;
tableArray{1,8}=results.WBFG.LogFitA;
tableArray{1,9}=results.WBFG.LogFitB;
tableArray{1,10}=results.WBFG.length_total;

%endpointDensity1
tableArray{1,11}=nan;
%endpointDensity2
tableArray{1,12}=nan;
%avgEndpointDist1
tableArray{1,13}=nan;
%avgEndpointDist2
tableArray{1,14}=nan;
%stDevEndpointDist1
tableArray{1,15}=nan;
%stDevEndpointDist2
tableArray{1,16}=nan;
%midpointDensity
tableArray{1,17}=nan;
%avgMidpointDist
tableArray{1,18}=nan;
%stDevMidpointDist
tableArray{1,19}=nan;
%norms.volumeProp
tableArray{1,20}=1;
%norms.countProp
tableArray{1,21}=1;
%norms.wireProp
tableArray{1,22}=1;
%endpointVol1
tableArray{1,23}=nan;
%endpointVol2
tableArray{1,24}=nan;

fieldNames={'stream_count', 'volume','avg_stream_length','stream_length_stdev','avgFullDisp','stDevFullDisp',...
    'LogFitA','LogFitB','length_total','endpointDensity1','endpointDensity2','avgEndpointDist1','avgEndpointDist2',...
    'avgEndpointDist2','stDevEndpointDist1','stDevEndpointDist2','endpointDensity1','endpointDensity2','midpointDensity',...
    'avgMidpointDist','stDevMidpointDist','norms.volumeProp','norms.countProp','norms.wireProp','endpointVolume1','endpointVolume2'};

fullFieldNames={'TractName','StreamlineCount', 'volume','avgerageStreamlineLength','streamlineLengthStdev','averageFullDisplacement','fullDisplacementStdev',...
    'ExponentialFitA','ExponentialFitB','StreamlineLengthTotal','Endpoint1Density','Endpoint2Density','AverageEndpointDistanceFromCentroid1',...
    'AverageEndpointDistanceFromCentroid2','stdevOfEndpointDistanceFromCentroid1','stdevEndpointDistanceFromCentroid2','MidpointDensity',...
    'averageMidpointDistanceFromCentroid','stDevOfMidpointDistanceFromCentroid','TotalVolumeProportion','TotalCountProportion','TotalWiringProportion','Endpoint1Volume','Endpoint2Volume'};

conditionals=11:19;

%results.WBFG.tractStats

%making it outside conditional
for itracts=1:length(results.WBFG.tractStats)
    tableArray{itracts+1,1}=results.WBFG.tractStats{itracts}.name;
    tableArray{itracts+1,2}=results.WBFG.tractStats{itracts}.stream_count;
    tableArray{itracts+1,3}=results.WBFG.tractStats{itracts}.volume;
    tableArray{itracts+1,4}=results.WBFG.tractStats{itracts}.avg_stream_length;
    tableArray{itracts+1,5}=results.WBFG.tractStats{itracts}.stream_length_stdev;
    tableArray{itracts+1,6}=results.WBFG.tractStats{itracts}.avgFullDisp;
    tableArray{itracts+1,7}=results.WBFG.tractStats{itracts}.stDevFullDisp;
    tableArray{itracts+1,8}=nan;
    tableArray{itracts+1,9}=nan;
    tableArray{itracts+1,10}=results.WBFG.tractStats{itracts}.length_total;
    
    if ~isfield(results.WBFG.tractStats{itracts},'endpointDensity1')
        %endpointDensity1
        tableArray{itracts+1,11}=nan;
        %endpointDensity2
        tableArray{itracts+1,12}=nan;
        %avgEndpointDist1
        tableArray{itracts+1,13}=nan;
        %avgEndpointDist2
        tableArray{itracts+1,14}=nan;
        %stDevEndpointDist1
        tableArray{itracts+1,15}=nan;
        %stDevEndpointDist2
        tableArray{itracts+1,16}=nan;
        %midpointDensity
        tableArray{itracts+1,17}=nan;
        %avgMidpointDist
        tableArray{itracts+1,18}=nan;
        %stDevMidpointDist
        tableArray{itracts+1,19}=nan;
    else
        %endpointDensity1
        tableArray{itracts+1,11}=results.WBFG.tractStats{itracts}.endpointDensity1;
        %endpointDensity2
        tableArray{itracts+1,12}=results.WBFG.tractStats{itracts}.endpointDensity2;
        %avgEndpointDist1
        tableArray{itracts+1,13}=results.WBFG.tractStats{itracts}.avgEndpointDist1;
        %avgEndpointDist2
        tableArray{itracts+1,14}=results.WBFG.tractStats{itracts}.avgEndpointDist2;
        %stDevEndpointDist1
        tableArray{itracts+1,15}=results.WBFG.tractStats{itracts}.stDevEndpointDist1;
        %stDevEndpointDist2
        tableArray{itracts+1,16}=results.WBFG.tractStats{itracts}.stDevEndpointDist2;
        %midpointDensity
        tableArray{itracts+1,17}=results.WBFG.tractStats{itracts}.midpointDensity;
        %avgMidpointDist
        tableArray{itracts+1,18}=results.WBFG.tractStats{itracts}.avgMidpointDist;
        %stDevMidpointDist
        tableArray{itracts+1,19}=results.WBFG.tractStats{itracts}.stDevMidpointDist;
    end
    %norms.volumeProp
    tableArray{itracts+1,20}=results.WBFG.tractStats{itracts}.norms.volumeProp;
    %norms.countProp
    tableArray{itracts+1,21}=results.WBFG.tractStats{itracts}.norms.countProp;
    %norms.wireProp
    tableArray{itracts+1,22}=results.WBFG.tractStats{itracts}.norms.wireProp;
    
    %cointinuing with a conditional so as not to mess up sequence
    if ~isfield(results.WBFG.tractStats{itracts},'endpointDensity1')
        %endpointDensity1
        tableArray{itracts+1,23}=nan;
        %endpointDensity2
        tableArray{itracts+1,24}=nan;
    else
        tableArray{itracts+1,23}=results.WBFG.tractStats{itracts}.endpointVolume1;
        %endpointDensity2
        tableArray{itracts+1,24}=results.WBFG.tractStats{itracts}.endpointVolume2;
    end
tableOut = cell2table(tableArray,...
    'VariableNames',fullFieldNames);

writetable(tableOut,fullfile(savePath,'output_FiberStats.csv'));

end