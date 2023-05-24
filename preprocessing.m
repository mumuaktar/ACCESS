%%%%%%%%%%%%%to unzip image%%%%%%%%%%%%%%%%%%
clc;clear;
NUM=64;
fileformat='.nii.gz';
prefix='warpedsub';
prefix_image='Warped';
for num=1:NUM
gunzip(strcat(prefix,num2str(num),fileformat));
end

%%%%%%%%%%%%%%%%%%%Extract Brain%%%%%%%%%%%%%%%%%%%%%
clc;clear;
NUM=64;
fileformat='.nii.gz';
prefix='warpedsub';
prefix_image='_t_rInverseWarped';
m=niftiread('ctamask.nii');
 for num=1:NUM
% s(:,:,:,num)=niftiread(strcat(prefix,num2str(num),prefix_image,fileformat));
 %s1(:,:,:,num)=fliplr(s(:,:,:,num));
 s1=niftiread(strcat(prefix,num2str(num),fileformat));
%  
%       [r,c,d]=size(s);
%      if d~=160
%          s1=imresize3(s,[221,221,160]);
%          
%      else
%         s1=s;
%      end

%   s2(:,:,:,num)=s(:,:,:,num).* m;
  s2=s1.* m;
  outputFileName = fullfile('brain', ['brain' num2str(num) '.nii']);
%   niftiwrite(s2(:,:,:,num), outputFileName);
niftiwrite(s2, outputFileName);
 end
 
%%%%%%%%%%%%%%Calcification Removal%%%%%%%%%%%%%%%%%
addpath('skull_free');
clc;clear
NUM=19;
fileformat='.nii';
prefix_image='skull_free';
D4=[];

a1=niftiread('skull_free1.nii');
a2=niftiread('skull_free2.nii');
a3=niftiread('skull_free3.nii');
a4=niftiread('skull_free4.nii');
a5=niftiread('skull_free5.nii');
a6=niftiread('skull_free6.nii');
a7=niftiread('skull_free7.nii');
a8=niftiread('skull_free8.nii');
a9=niftiread('skull_free9.nii');
a10=niftiread('skull_free10.nii');
a11=niftiread('skull_free11.nii');
a12=niftiread('skull_free12.nii');
a13=niftiread('skull_free13.nii');
a14=niftiread('skull_free14.nii');
a15=niftiread('skull_free15.nii');
a16=niftiread('skull_free16.nii');
a17=niftiread('skull_free17.nii');
a18=niftiread('skull_free18.nii');
a19=niftiread('skull_free19.nii');

aa=[a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a15;a16;a17;a18;a19];

max_val=max(aa(:));
min_val=min(aa(:));
rng=max_val-min_val;


 for num=1:NUM
 s(:,:,:,num)=niftiread(strcat(prefix_image,num2str(num),fileformat));
 scaled_image(:, :, :, num) = (s(:,:,:,num)-max_val)/(rng);
 D2=im2double(imgaussfilt3(scaled_image(:,:,:,num),3));
 im=reshape(D2,221*221*160,1);
 D4=[D4 im];
 end
 save('D4.mat','D4');
 D=im2double(D4);
 
 [A_hat E_hat iter] = inexact_alm_rpca(D);
 
 S1=reshape(E_hat,221,221,160,19);
 L1=reshape(A_hat,221,221,160,19);
 S1(S1<0)=0;
 
 SliceBrowser(S1);

 
 
sparse=zeros(221,221,160);
for i=1:19
sparse=sparse+S1(:,:,:,i);
end
average=sparse/19;
path_a='C:\mumu\data\data_info\final_sparse';
outputFileName_avg = fullfile(path_a, ['Subject_84' '.nii']);
niftiwrite(average,outputFileName_avg);
niftiwrite(average,'Subject_84.nii');
low=zeros(221,221,160);
for i=1:19
low=low+L1(:,:,:,i);
end
avg=low/19;
niftiwrite(avg,'Low_rank_84.nii');

%%%%%%%Projection%%%%%%%%%%%%%%%%%%%%%
 I=niftiread('Subject_84.nii');
 ax=median(I,3);
 cor=mean(I,2);
 cor=squeeze(cor);
 num=84;
 path_c='C:\mumu\data\data_info\final_coronal';
  path_a='C:\mumu\data\data_info\final_axial';
outputFileName_a = fullfile(path_a, ['axial' num2str(num) '.mat']);
save(outputFileName_a,'ax');
outputFileName_c = fullfile(path_c, ['coronal' num2str(num) '.mat']);
save(outputFileName_c,'cor');
