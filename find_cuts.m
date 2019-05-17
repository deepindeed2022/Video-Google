% Removing similar frames

clear;
close;
% load('Large_frames_2.mat');
% load('HarrisLaplace_feat_descript.mat');
load('MSER_feat_descript.mat');
frames_features = d2;
n = length(images_frames);
cnt = 1;
maxi = -100;

flag = zeros(n,1);

for i=1:n-1
    disp(i);
    im1 = double(rgb2gray(images_frames{1,i}));
    im2 = double(rgb2gray(images_frames{1,i+1}));
    dist = sqrt(sum(sum((im1-im2).^2)));
    maxi = max(maxi,dist);
end

threshold = 0.5*maxi;
disp(threshold);

for i=1:n-1
    disp(i);
    im1 = double(rgb2gray(images_frames{1,i}));
    im2 = double(rgb2gray(images_frames{1,i+1}));
    dist = sqrt(sum(sum((im1-im2).^2)));
    
    if(dist > threshold)
        disp(dist);
        cut{cnt} = i;
        flag(i) = 1;
        flag(i+1) = 1;
        cnt = cnt + 1;
    end
end

cnt = 1;
for i=1:n
    if flag(i) == 1
        keyframes_2{cnt} = images_frames{1,i};
        keyframes_features_2{cnt} = frames_features{1,i};
        cnt = cnt + 1;
    end
end

% save('Large_keyframes_2.mat','keyframes_2','keyframes_features_2');
% save('HarrisLaplace_feat_descript.mat','keyframes_2','keyframes_features_2');
save('MSER_feat_descript.mat','keyframes_2','keyframes_features_2');
