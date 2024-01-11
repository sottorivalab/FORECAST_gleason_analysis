function Counts = CountTileRegions(TilePath, Colours, MinArea)
    if nargin < 3
         MinArea = 0;
    end

    files = dir(fullfile(TilePath, '*.png'));
    
    if ~isempty(files)
        Counts = cell(length(files), 1);

        parfor i=1:length(files)
            try
                I = imread(fullfile(files(i).folder, files(i).name));

                SubCounts = zeros(1, size(Colours, 1));

                for j=1:length(SubCounts)
                    if ndims(I) == 3
                        B = I(:, :, 1)==Colours(j, 1) & I(:, :, 2)==Colours(j, 2) & I(:, :, 3)==Colours(j, 3);
                    else
                        B = I(:, :)==Colours(j);
                    end

                    if MinArea == 0
                        SubCounts(j) = nnz(B);
                    else
                        CC = bwconncomp(B, 4);
                        CCSizes = cellfun(@(x) size(x, 1),  CC.PixelIdxList);
                        SubCounts(j) = sum(CCSizes(CCSizes > MinArea));
                    end
                end
            catch exception
                SubCounts = zeros(1, size(Colours, 1));
            end
            
            Counts{i} = SubCounts;
        end

        Counts = sum(cat(1, Counts{:}), 1);
    else
        Counts = zeros(1, size(Colours, 1));
    end
end

