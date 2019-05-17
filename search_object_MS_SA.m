% Object retrieval using combined SA and MSER 

clear all;
close all;

load('final_keyframes.mat'); 
load('final_cluster.mat');
load('final_tfidf.mat');

ncluster = size(cluster,1);
n = length(keyframes_features);

%Selecting object to be searched
search_image = imcrop(keyframes{1,76});

[~,c,no] = size(search_image);

 
 I2 = single(rgb2gray(search_image));
 
 % SA features for object to be searched
 frames = vl_covdet(I2, 'method', 'HarrisLaplace'); 
   
 f = frames;
 fc = [f(1,:);f(2,:);f(3,:);f(4,:)] ;
 [f2,search_image_feature_1] = vl_sift(I2,'frames',fc) ;
 
 % MS features for object to be searched
 
 I3 = uint8(rgb2gray(search_image));
 [r,f] = vl_mser(I3,'MinDiversity',0.8,...
                'MaxVariation',0.8,...
                'Delta',11) ;
 fc = [f(2,:);f(1,:);f(3,:);f(4,:)] ;
 [f2,search_image_feature_2] = vl_sift(I2,'frames',fc) ;
 
 search_image_feature = cat(2,search_image_feature_2,search_image_feature_2);


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
    query(i) = dot(words_norm,freq_norm(i,:));
end

tic;
[sortedX,I] = sort(query,'descend');
toc;

tic;
figure(4),
for i=1:6
   
    subplot(3,2,i)
    imshow(keyframes{1,I(i)});
  
end
toc;