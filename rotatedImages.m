
% rotate image up to num times up to a full rotation
% if the path is empty, this sticks the result in the root directory
function rotatedImages(imagename, num)
degrees = 360/num;
A = imread(imagename);
for i = 1:num-1
    newimage = imrotate(A,i*degrees,'bilinear','crop');
    [filepath,name,ext] = fileparts(imagename)
    newimagename = append(filepath, filesep, name, "_rot_", string(degrees*i),ext)
    imwrite(newimage,newimagename, 'jpg');
    % imshow(newimage)
end
end