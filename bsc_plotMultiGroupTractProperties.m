function bsc_plotMultiGroupTractProperties(workingDirs,identifierTag,plotProperties,SaveDir)


% lazy way to get info from first group
[~,domainNames,propertyNames,~]= bsc_normalizeStatMeasures(workingDirs{1},identifierTag);

%get the number of groups, just needs to count from 1 to number of
%groups, really
groupmap=1:length(workingDirs);


for iGroups= 1:length(workingDirs)
    
    %get csv paths for this specific project/group dir
    csvPaths = tractStatNamesGen(workingDirs{iGroups},identifierTag);
    
    %create a group average and std table
    [currAvgTable, currStdTable]=bsc_tableAverages(csvPaths);
    
    %index at 2 to get rid of names vec and wbfg vec KEEP THIS IN MIND IF
    %YOU TRY AND GENERALIZE THIS TO OTHER PROJECTS.  ONE WAY TO DEAL WITH
    %IT IS TO CAT AN EXTRA DUMMY TRACT / DOMAIN AT THE TOP, OR TO CHANGE
    %THE BELOW INDEXING
    currAvgData=currAvgTable{2:end,2:end};
    currStdData=currStdTable{2:end,2:end};
    
    %cat all data into a 3D structure, we will only be passing a 2D struc
    %to the multiPlot data, because we have no actual replications and are
    %treating whole projects as subjects.  Thus the variability that
    %originally would have come from within subject differences is now
    %coming from between subject differences.
    if iGroups== 1
        catAvgData=currAvgData;
        catStdData=currStdData;
    else
        catAvgData=cat(3,catAvgData,currAvgData);
        catStdData=cat(3,catAvgData,currAvgData);
    end
end

for iProperties=1:length(plotProperties)
    %parse the plotProperty, accepts exact string or index
    if ischar(plotProperties{iProperties})
        %in the event that nothing is found you get an error?
        %-1 because the user input would never actually consider tractnames
        %a property, even though the table considers it to be so
        propertyInd=find(strcmp(plotProperties{iProperties},propertyNames))-1;
        
        %would it ever return 0?
        if or(isempty(propertyInd),propertyInd==-1)
            error('\n plot property mislabeled or not found')
        end
    else
        %if error here, likely improperly indexing properties.
        propertyInd=plotProperties(iProperties);
    end
    
    %using propertyInd to index the property name should reveal if there
    %are any indexing problems.
    for iGroups= 1:length(workingDirs)
        %column is always 1 because no replications
        
        %THIS NEEDS TO BE TESTED
        %will crap out here if you are passing data sets with diffierent
        %numbers of properties or tracts, probably
        keyboard
        meanDataMatrix(iGroups,1,:)=squeeze(catAvgData(:,propertyInd,iGroups));
        stdDataMatrix(iGroups,1,:)=squeeze(catStdData(:,propertyInd,iGroups));
        
        %treat different subjects as replications for the purposes of this function
        bsc_multiPlotData_v3(meanDataMatrix,stdDataMatrix,domainNames{2:end},propertyNames(propertyInd),SaveDir,[],groupmap)
    end
end

end