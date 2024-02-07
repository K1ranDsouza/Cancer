

allfiles = dir('ds_AASCII_fixed/Cancer');


for f = 1:length(allfiles)
    % skip current directory '.'
    if (strcmp(allfiles(f,1).name,'.')) 
        continue
    end
    % skip parent directory '..'
    if (strcmp(allfiles(f,1).name,'..')) 
        continue
    end
    % rotate image in 12 positions
    oldname = append('ds_AASCII_fixed', filesep, 'Cancer', filesep, allfiles(f).name);
    newname = append('ds_AASCII_rotcol', filesep, 'Cancer', filesep, allfiles(f).name);
    cropImages(oldname, newname);
    rotatedImages(newname, 12);
end