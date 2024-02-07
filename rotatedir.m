function rotatedir(frombasedirname, tobasedirname, numrotations)
% allfiles = dir('ds_AASCII_fixed/Cancer');

subdirs = ["Cancer", "noCancer"];

for s = 1:2
    dirname = append(frombasedirname, filesep, subdirs(s))
    allfiles = dir(dirname);

    for f = 1:length(allfiles)
        % skip current directory '.'
        if (strcmp(allfiles(f,1).name,'.'))
            continue
        end
        % skip parent directory '..'
        if (strcmp(allfiles(f,1).name,'..'))
            continue
        end
        % rotate image in numrotations positions
        oldname = append(frombasedirname, filesep, subdirs(s), filesep, allfiles(f).name);
        newname = append(tobasedirname, filesep, subdirs(s), filesep, allfiles(f).name);
        cropImages(oldname, newname);
        rotatedImages(newname, numrotations);
    end
end