% Object Retrieval using both SIFT features


clear all;
close all;
load('Large_keyframes_2.mat');cd 
load('Large_keyframes_new_cluster.mat');
load('Large_tfidf.mat');

ncluster = size(cluster,1);
n = length(keyframes_features_2);

%Selecting object to be searched
search_image = imcrop(keyframes_2{1,21});

[~,c,no] = size(search_image);
if(no == 3)
   [fim,search_image_feature] = vl_sift(single(rgb2gray(search_image)));
else
   [fim,search_image_feature] = vl_sift(single(search_image));
end

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

figure,
for i=1:6  
    subplot(3,2,i)
    imshow(keyframes_2{1,I(i)});
end
