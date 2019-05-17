%Combining feature descriptors MS and SA

clear;
P = load('MSER_feat_descript.mat');
Q = load('HarrisLaplace_feat_descript.mat');

keyframes_1 = P.keyframes_2;
keyframes_features_1 = P.keyframes_features_2;
keyframes_2 = Q.keyframes_2;
keyframes_features_2 = Q.keyframes_features_2;
n = length(keyframes_1);
cnt = 1;
for i=1:n
    keyframes{cnt} = keyframes_1{i};
    keyframes_features{cnt} = keyframes_features_1{i};
    cnt = cnt + 1;
end

n = length(keyframes_2);
for i=1:n
    keyframes{cnt} = keyframes_2{i};
    keyframes_features{cnt} = keyframes_features_2{i};
    cnt = cnt + 1;
end

save('final_keyframes.mat','keyframes','keyframes_features');