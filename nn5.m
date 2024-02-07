
%With given data applies it to a NN in said folder
% dsPath = "ds_AASCII"
% dsPath = "ds_HASCII"
% dsPath = "ds_CONCAT"
% dsPath = "ds_AASCII_fixed"
dsPath = "images/ds_AASCII_rotcol"
imds = imageDatastore(dsPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

% show 4 figures in the datastore
figure;
perm = randperm(133, 4);
for i = 1:4
    subplot(2,2, i);
    imshow(imds.Files{perm(i)});
end

labelCount = countEachLabel(imds)

img = readimage(imds,1);
size(img)

% jpeg image size is 656 x 875 x 3 (RGB)

numTrainFiles = 120;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize'); 

layers = [
    imageInputLayer([656 875 3])
    
    convolution2dLayer(16,96, 'Stride', 4, 'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(4,'Stride',4)
    
    convolution2dLayer(16,192,'Stride', 8, 'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(4,'Stride',4)
    
    convolution2dLayer(16,256,'Stride', 16, 'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];


% training
epochs=2000;
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.1, ...
    'MiniBatchSize', 16, ...
    'MaxEpochs', epochs, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',10, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);


