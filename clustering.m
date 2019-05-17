clear;
% load('Large_keyframes_2.mat','keyframes_features_2');
load('HarrisLaplace_feat_descript.mat','keyframes_features_2');
% load('MSER_feat_descript.mat','keyframes_features_2');

X1 = [keyframes_features_2{1,:}];

ncluster = 100;

tic;
[C1,idx1] = vl_kmeans(double(X1),ncluster);
toc;
C = C1';
idx = idx1';

% save('Large_keyframes_cluster.mat','C','idx');
save('SA_cluster.mat','idx','C');
% save('MS_cluster.mat','C','idx');