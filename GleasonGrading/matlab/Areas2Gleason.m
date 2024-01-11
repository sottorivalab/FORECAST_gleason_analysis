function [PrimaryGrade, SecondaryGrade] = Areas2Gleason(Gleason3Area, Gleason4Area, Gleason5Area, MinArea)
    if nargin < 4
        MinArea = 0;
    end

    Areas = [Gleason3Area, Gleason4Area, Gleason5Area];
    [Areas, idxs] = sort(Areas);

    PrimaryGrade = 0;
    SecondaryGrade = 0;

    if Areas(end) >= MinArea
        PrimaryGrade = idxs(end)+2;

        if Areas(end-1) >= MinArea
            SecondaryGrade = idxs(end-1)+2;
        else
            SecondaryGrade = idxs(end)+2;
        end
    end
end

