% Computing Maximally stable features
clear; 
oldFolder = cd('/home/temp/Video-Google/Frames/');

imagefiles1 = dir('*.png');
imagefiles2 = dir('*.jpg');
imagefiles3 = dir('*.jpeg');

imagefiles = [imagefiles1 ; imagefiles2 ; imagefiles3];

cnt = 1;
nfiles = length(imagefiles);
tic;
for i=1:nfiles
   disp(i);
   currentfilename = imagefiles(i).name;
   currentimage = imread(currentfilename);

    I2 = uint8(rgb2gray(currentimage));
    I3 = single(rgb2gray(currentimage));
    [r,f] = vl_mser(I2,'MinDiversity',0.9,...
                'MaxVariation',0.9,...
                'Delta',11) ;
    fc = [f(2,:);f(1,:);f(3,:);f(4,:)] ;
    [f2,d2{cnt}] = vl_sift(I3,'frames',fc) ;
    images_frames{cnt} = currentimage;
    cnt = cnt + 1;
end
toc;

cd(oldFolder);
save('MSER_feat_descript','d2','images_frames');
% save('Large_frames_2.mat','frames_features','images_frames');