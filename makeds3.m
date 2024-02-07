
%Takes csv file and converts each col to jpg files
%run this program first
T = table2array(readtable('HASCII.csv'));
sample_num = T(1,:)
cancer = T(2,:)
cell_num = T(3,:)
pics = T(4:end, 1:end);
[m,n] = size(pics)
mkdir ds_HASCII_fixed/noCancer
mkdir ds_HASCII_fixed/Cancer
% 
for i = 1:n
    pic = reshape(pics(:,i),[512,512]);
    size(pic)
    if(cancer(i) == 0)
        picname = append('ds_HASCII_fixed/noCancer/', string(i), '.jpg');
    else
        picname = append('ds_HASCII_fixed/Cancer/', string(i), '.jpg');
    end
    imagesc(pic)
    % set(gcf, 'MenuBar', 'none')
    % set(gcf, 'DataAspectRatioMode', 'auto')
    axis off
    set(gca, 'Position', [0 0 1 1])
    saveas(gcf,  picname, 'jpeg')
    picname
    % imwrite(pic, picname);
end