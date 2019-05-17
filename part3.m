clc;
close all;
clear all;

datasize = 500;
d1 = importdata('C:\ThirdYearSemester1\ComputerVision\Lou\dfirst.mat');
D = d1(1:datasize);
%D = cell2mat(D);

C = importdata('C:\ThirdYearSemester1\ComputerVision\Lou\C500_100.mat');
idx = importdata('C:\ThirdYearSemester1\ComputerVision\Lou\idx500_100.mat');

clusters = 100;
totalcount = zeros(clusters,1);
framecount = zeros(datasize,clusters);
featurecount = zeros(datasize,1);
ranks = zeros(datasize,clusters);

features = size(idx);
features = features(1);
num = size(D);
num = num(2);

imagenum = 1;
count = 0;

%-----COMPUTE THE NUMBER OF FEATURES IN EACH FRAME------
for i = 1:datasize
    a = D{i};
    [b,c] = size(a);
    featurecount(i) = c;
end

%-----COUNT NUMBER OF FEATURES OF A TYPE FOR EACH FRAME AND DATABASE------
for i=1:features
    count=count+1;
    k = idx(i);
    totalcount(k)=totalcount(k)+1;
    framecount(imagenum,k)=framecount(imagenum,k)+1;
    if count == featurecount(imagenum)
        imagenum=imagenum+1;
        count = 0;
    end
end
            
for i=1:datasize
    framefeatures = sum(framecount,2);
    for j=1:clusters
        ranking = (framecount(i,j)/framefeatures(i))*log(datasize/totalcount(j));
        ranks(i,j) = ranking;
    end
end
    
