function n = fixname(oldname)
%splits up name when there is a space
x = string(split(oldname, '_'));
if (length(x) > 1) 
    x(end) = [];
    n = join(x, '_');
else
    n = oldname;
end
end