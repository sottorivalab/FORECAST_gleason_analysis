function makeGleasonCellCSVs(csvPath, gleasonPath, outPath, colours, labels)
    if ~isfolder(outPath)
        mkdir(outPath);
    end

    csvs = dir(fullfile(csvPath, '*.csv'));

    for i=1:length(csvs)
      T = readtable(fullfile(csvs(i).folder, csvs(i).name));

      if ~isempty(T)
        I = imread(fullfile(gleasonPath, strrep(csvs(i).name, '.csv', '.png')));
        sz = size(I);
        I = reshape(I, [], 3);

        T.V1 = strrep(T.V1, 'flagblue', 'immune');
        T.V1 = strrep(T.V1, 'pinblue', 'immune');
        T.V1 = strrep(T.V1, 'pingreen', 'stromal');
        T.V1 = strrep(T.V1, 'unk', 'unknown');

        epiCells = find(strcmp(T.V1, 'pinred'));
        indices = sub2ind(sz(1:2), T.V3(epiCells)+1, T.V2(epiCells)+1);

        epiColours = I(indices, :);

        for j=1:length(labels)
            labelCells = (epiColours(:, 1) == colours(j, 1)) & (epiColours(:, 2) == colours(j, 2)) & (epiColours(:, 3) == colours(j, 3));
            T.V1(epiCells(labelCells)) = {[labels{j} 'Epithelial']};
        end
      end

      writetable(T, fullfile(outPath, csvs(i).name));
    end
end
