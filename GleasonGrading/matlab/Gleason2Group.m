function Group = Gleason2Group(Primary,Secondary)
    switch Primary+Secondary
        case 6
            Group = 1;
        case 7
            if Primary == 3
                Group = 2;
            else
                Group = 3;
            end
        case 8
            Group = 4;
        case 9
            Group = 5;
        case 10
            Group = 5;
        otherwise
            Group = 0;
    end
end

