% Object retrieval using SA features

clear all;
close all;

load('HarrisLaplace_feat_descript.mat');
load('SA_new_cluster.mat');
load('SA_Large_tfidf.mat');

ncluster = size(cluster,1);
n = length(keyframes_features_2);

%Selecting object to be searched
search_image = imcrop(keyframes_2{1,86});

[~,c,no] = size(search_image);

 I2 = single(rgb2gray(search_image));
 frames = vl_covdet(I2, 'method', 'HarrisLaplace'); 
   
 f = frames;
 fc = [f(1,:);f(2,:);f(3,:);f(4,:)] ;
 [f2,search_image_feature] = vl_sift(I2,'frames',fc) ;
 
dist = pdist2(double(search_image_feature'),cluster);
[M,I] = min(dist,[],2);
hstcnt = histcounts(I,ncluster);
if(sum(histcounts(I,ncluster)) == 0)
    words = 0;
else
    words = hstcnt./sum(hstcnt);
    words_norm = hstcnt./sqrt(sum(hstcnt.^2));
end

for i=1:n
    tic;
    query(i) = dot(words_norm,freq_norm(i,:));
    toc;
end

[sortedX,I] = sort(query,'descend');

figure(4),
for i=1:6    
    subplot(3,2,i)
    imshow(keyframes_2{1,I(i)});
end