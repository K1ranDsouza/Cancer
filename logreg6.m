% generate mean/var of concentric squares to use as rotation invariant
% features for logistic regression
%takes into consideration the 5 choose 2 method 

T = table2array(readtable('AASCII.csv'));
T1 = readtable('AASCII.csv');
%U = table2array(readtable('HASCII.csv'));
sample_num = T(1,:);
cancer = T(2,:);
cell_num = T(3,:);
pics= T(4:end, 1:end);
%picsH = U(4:end, 1:end);
[m,n] = size(pics);

names = string(T1.Properties.VariableNames);
cancernames = names(find(cancer>0));
nocancernames = names(find(cancer==0));
purecancernames = arrayfun(@fixname,cancernames);
cancerpatients = unique(purecancernames);
purenocancernames = arrayfun(@fixname,nocancernames);
nocancerpatients = unique(purenocancernames);

train_cancerpatients = cancerpatients(4:end);
train_nocancerpatients = nocancerpatients(3:end);
test_cancerpatients = cancerpatients(1:3);
test_nocancerpatients = nocancerpatients(1:2);

testpatients = [test_cancerpatients test_nocancerpatients];
testcols = getpatientcols(names, testpatients);
trainpatients = [train_cancerpatients train_nocancerpatients];
traincols = getpatientcols(names, trainpatients);

testTbl = [cancer(testcols); pics(:,testcols)];
trainTbl = [cancer(traincols); pics(:,traincols)];


mvfeaturestrain = [];   % make sure it starts empty before appending to it

for i = 1:size(trainTbl, 2)
    pic = reshape(trainTbl(2:end,i),[512,512]);
    mvfeaturesthis = meanVar(pic);
    mvfeaturestrain = [mvfeaturestrain; round(trainTbl(1,i)/2) mvfeaturesthis(1,:) mvfeaturesthis(2,:)];
end


mvfeaturestest = [];   % make sure it starts empty before appending to it

for i = 1:size(testTbl, 2)
    pic = reshape(testTbl(2:end,i),[512,512]);
    mvfeaturesthis = meanVar(pic);
    mvfeaturestest = [mvfeaturestest; round(trainTbl(1,i)/2) mvfeaturesthis(1,:) mvfeaturesthis(2,:)];
end

X = mvfeaturestest(:,2:end)
modc = mvfeaturestest(:,1);
[yfit,scores] = trainedModel3.predictFcn(X);
accuracy = modc == yfit
correct = sum(accuracy)/length(accuracy)

% here we run the classification learner script on two classes