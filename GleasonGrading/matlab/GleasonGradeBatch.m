function GleasonGradeBatch(InFolder, OutFile, Colours, MinCountArea, MinGradeArea)
    files = dir(InFolder);
    files = files(~ismember({files.name}, {'.', '..'}));
    
    PrimaryGrades = zeros(length(files), 1);
    SecondaryGrades = zeros(length(files), 1);
    GradeGroups = zeros(length(files), 1);
    
    for i=1:length(files)
        Counts = CountTileRegions(fullfile(files(i).folder, files(i).name), Colours, MinCountArea);
        [PrimaryGrades(i), SecondaryGrades(i)] = Areas2Gleason(Counts(1), Counts(2), Counts(3), MinGradeArea);
        GradeGroups(i) = Gleason2Group(PrimaryGrades(i), SecondaryGrades(i));
    end
    
    OutTable = array2table([PrimaryGrades, SecondaryGrades, GradeGroups] , 'RowNames', {files.name}, 'VariableNames', {'PrimaryGrade', 'SecondaryGrade', 'ISUPGroup'});
    
    writetable(OutTable, OutFile, 'WriteVariableNames', true, 'WriteRowNames', true);
end

