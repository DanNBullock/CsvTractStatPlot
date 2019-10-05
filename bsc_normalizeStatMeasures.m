function [subjNames,domainNames,propertyNames,valueArray]= bsc_normalizeStatMeasures(workingDir,identifierTag)

%workingDir='/N/dc2/projects/lifebid/HCP/Dan/EcogProject/proj-5c33a141836af601cc85858d'
%identifierTag='measures'

csvPaths = tractStatNamesGen(workingDir,identifierTag);

[avgTable, stdTable]=bsc_tableAverages(csvPaths);

avgData=avgTable{1:end,2:end};
stdData=stdTable{1:end,2:end};

workingDirContents=dir(workingDir);
contentNames={workingDirContents(:).name};
subjectBool=contains(contentNames,'sub');
subjInd=find(subjectBool);
subjNames={workingDirContents(subjInd).name};



propertyNames=avgTable.Properties.VariableNames;
domainNames=avgTable{1:end,1};

catDomains=[];
catData=[];
%lord help you if your first subject's classification structure was
%improper
for isubjects =1:length(csvPaths)
    if exist(csvPaths{isubjects},'file')
        currTable=readtable(csvPaths{isubjects});
        
        currDomains=currTable{1:end,1};
        currData=currTable{1:end,2:end};
        
        %if your first subject is empty given your criteria its going to
        %cause a problem.  Also you need to sort out your life.
        if isempty(catData)
            catData=currData;
        else
            
            %checks to see that same domainsize is being merged
            checkCat=length(catDomains)==length(currDomains);
            if checkCat
                %if they are the same size, we still need to check to see
                %if the order of the items matches
                [~,ia,ib] = intersect(catDomains,currDomains,'stable');
                if~isequal(ia,ib)
                    %could error here if you have two diffrent
                    %classifications with exactly the same number of items
                    %in them
                    for iDomains=1:length(currDomains)
                        %again, huge assumption about correspondence here
                        correspondingInd=ib(iDomains);
                        %lets test it just to be sure
                        %fprintf('\n %s %s',catDomains{(iDomains)},currDomains{correspondingInd})
                        spliceData(iDomains,:)=currData(correspondingInd,:);
                    end
                    %once you've rebuilt the structure transfer it to
                    %currData
                    currData=spliceData;
                    clear spliceData
                else
                    %if they are equal, then nothing needs to be done
                end
                %if they are of different lengths then we now have to do
                %some work to figure out what's going on
            else
                if length (catDomains)>length(currDomains)
                [diffDomains] = setdiff(catDomains,currDomains,'stable');
                [~, ia, ib]=intersect(catDomains,diffDomains,'stable');
                [~,presentA,presentB] = intersect(catDomains,currDomains,'stable');
                    for iDomains=1:length(catDomains)
                        if ~ismember(iDomains,ia)
                            %might screw up if iDomains isn't tantamount to
                            %the presentA, but whatever?
                        correspondingInd=find(iDomains==presentA); 
                        spliceData(iDomains,:)=currData(correspondingInd,:);
                        else
                        spliceData(iDomains,:)=NaN(1,length(catData(1,:,1)));
                        end
                    end
                    currData=spliceData;
                    clear spliceData
                elseif length (catDomains)<length(currDomains)
                %deal with it when it comes up #lazy
                keyboard
                end 
            end
            %now we aapply the z transform
             %valueArray(:,:,isubjects)=rdivide(minus(currData,avgData),stdData);
            %cat data not really used
            %catData=cat(3,catData,currData); 
        end
    catDomains=cat(1,currDomains,catDomains);
    catDomains=unique(catDomains,'stable');
    
    else
        
        fprintf('\n no %s data for subject %s', identifierTag ,subjNames{isubjects})
        currentCatDim=size(catData);
        %lol
        currData=nan(currentCatDim(1),currentCatDim(2));
        catData=cat(3,catData,currData);
    end  
    valueArray(:,:,isubjects)=rdivide(minus(currData,avgData),stdData);  
end

      
        
end