% Combining SA and MS clusters

clear;
P = load('SA_new_cluster.mat');
Q = load('MS_new_cluster.mat');

cluster_MS = Q.cluster;
cluster_SA = P.cluster;
cluster = cat(1,cluster_MS,cluster_SA);

save('final_cluster.mat','cluster');