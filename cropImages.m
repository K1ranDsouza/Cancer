function cropImages(imagename, newimagename)
%takes image and crops it into a cricle with r being half of the smaller
%dimension
I = imread(imagename);
%imshow(I)
ImageSize = size(I)
msize = min(ImageSize(1), ImageSize(2));
center = [ImageSize(1)/2, ImageSize(2)/2, msize/2];
[x,y] = ndgrid((1:ImageSize(1))-center(1),(1:ImageSize(2))-center(2));
mask = uint8((x.^2 + y.^2)<center(3)^2);
croppedImage = uint8(zeros(size(I)));
croppedImage(:,:,1) = I(:,:,1).*mask;
croppedImage(:,:,2) = I(:,:,2).*mask;
croppedImage(:,:,3) = I(:,:,3).*mask;
%imshow(croppedImage);
imwrite(croppedImage, newimagename)
end
