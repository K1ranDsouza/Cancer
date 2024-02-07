function cols = getpatientcols(names, patients)
%returns which patient a column corrosponds to
cols = [];
for i = 1:length(names)
    fname = fixname(names(i));
    if (ismember(fname, patients))
    % if (strcmp(patientname, fixname(names(i))))
        cols = [cols i];
    end
end
end