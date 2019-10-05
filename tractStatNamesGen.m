function csvPaths = tractStatNamesGen(workingDir,identifierTag)


%workingDir='/N/dc2/projects/lifebid/HCP/Dan/EcogProject/proj-5c33a141836af601cc85858d'
%identifierTag='measures'


workingDirContents=dir(workingDir);


contentNames={workingDirContents(:).name};

statDir=fullfile(workingDir,'tractStats');
if ~isdir(fullfile(statDir))
    mkdir(fullfile(statDir))
else
    
end

subjectBool=contains(contentNames,'sub');
subjInd=find(subjectBool);

for iSubj=1:length(subjInd)
subjectDir=fullfile(workingDir,contentNames{subjInd(iSubj)});
subjDirCotnents=dir(subjectDir);
dirIndex=find(contains({subjDirCotnents.name},identifierTag)&contains({subjDirCotnents.name},'quantification'));
dataDir=fullfile(subjectDir,subjDirCotnents(dirIndex).name);
csvPaths{iSubj}=fullfile(dataDir,'output_FiberStats.csv');
end

end

