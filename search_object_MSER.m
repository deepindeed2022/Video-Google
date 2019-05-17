% Object retrieval using MSER

clear all;
close all;

load('MSER_feat_descript.mat');cd 
load('MS_new_cluster.mat');
load('MS_Large_tfidf.mat');

ncluster = size(cluster,1);
n = length(keyframes_features_2);

%Selecting object to be searched
search_image = imcrop(keyframes_2{1,86});

[~,c,no] = size(search_image);

I2 = uint8(rgb2gray(search_image));
I3 = single(rgb2gray(search_image));
[r,f] = vl_mser(I2,'MinDiversity',0.8,...
                'MaxVariation',0.8,...
                'Delta',11) ;
fc = [f(2,:);f(1,:);f(3,:);f(4,:)] ;
[f2,search_image_feature] = vl_sift(I3,'frames',fc) ;  
    

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

[sortedX,I] = sort(query,'descend');

figure,
for i=1:6
    
    subplot(3,2,i)
    imshow(keyframes_2{1,I(i)});
    
end
