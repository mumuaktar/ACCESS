clc;clear;
tic


NUM=19;
fileformat='.nii';
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
%aa=[a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12];

max_val=max(aa(:));
min_val=min(aa(:));
rng=max_val-min_val;

 fileformat='.nii';
 prefix_image='skull_free';
 D4=[];
 for num=1:NUM
 s(:,:,:,num)=niftiread(strcat(prefix_image,num2str(num),fileformat));
 s1(:,:,:,num)=imresize3( s(:,:,:,num),[221 221 160]);
%  s1=s(:,:,:,num);
%  s11=s1(:,:,60:110);
%  ss=max(s11,[],3);
%  figure,imagesc(ss),colormap(gray)
%  scaled_image = (s11-max_val)/(rng);
 scaled_image(:, :, :, num) = (s1(:,:,:,num)-max_val)/(rng);  
 scaled_image(:,:,:,num)=im2double(imgaussfilt3(scaled_image(:,:,:,num),1));
 im=reshape(scaled_image(:, :, :, num),221*221*160,1);
%im=reshape(scaled_image,221*221*51,1);
 D4=[D4 im];
 end


  D=im2double(D4);
  %  [A_hat,E_hat,iter] = inexact_alm_rpca(D);
     [A, ~ ] = InfaceExtFrankWolfe(D, [],[], 100);
%  
  %   E = D-A;
%     E(E<0)=0;
  S1=reshape(E_hat,221,221,160,19);
    L1=reshape(A_hat,221,221,160,19);
%   S1(S1<0)=0;
  
%   S1=reshape(E,221,221,160,19);
%   L1=reshape(A,221,221,160,19);
  S1(S1<0)=0;
   L1(L1<0)=0;

 mip_S=max(S1,[],4);
 ss=max(mip_S,[],3);
figure,imagesc(ss),colormap(gray)
%  path_sparse='\\perf-loy-nas.concordia.ca\home\home\m_ktar\sparse_frmc';
%  path_f='\\perf-loy-nas.concordia.ca\home\home\m_ktar\sparse_mip_frmc_processed';
%  path_f1='\\perf-loy-nas.concordia.ca\home\home\m_ktar\sparse_mip_frmc';
%  outputFileName_avg = fullfile(path_sparse, ['sparse_ff_c' num2str(14) '.nii']);
%  niftiwrite(S1,outputFileName_avg)
%      
% outputFileName_avg = fullfile(path_f1, ['sparse_mip_c' num2str(14) '.nii']);
% niftiwrite(mip_S,outputFileName_avg);
niftiwrite(mip_S,'sparse_n62.nii');

% 
%%%%%%%%%%%%% Binary Processing of MIP%%%%%%%%%%%%%%%%%%%%%%%%%
% power =1;
%     coef = 1;
%     ForegEn = coef * E .^ power;
% Th = (1/5) * max(max(ForegEn));
% ForegMask = ForegEn > .025;
%     ForegMask = reshape(ForegMask,221, 221,160, []);
% %ForegMask = imclose(ForegMask, strel('rectangle', [5, 5]));
% a=max(ForegMask,[],4);
% aa=max(a,[],3);
% %figure,imagesc(aa),colormap(gray)
% aa1=bwareaopen(aa,50);
% figure,imagesc(aa1),colormap(gray)
% for i=1:160
% m1=mip_S(:,:,i);
% m1(~aa1)=0;
% mm(:,:,i)=m1;
% end
% mmmm=max(mm,[],3);
% figure,imagesc(mmmm),colormap(gray)
% 
% 
% outputFileName_avg = fullfile(path_f, ['sparse_mip_pro' num2str(14) '.nii']);
% niftiwrite(mm,outputFileName_avg);
% % 
%  m_l=niftiread('seg_left.nii');
%  m_r=niftiread('seg_right.nii');
%  left=V .* m_l;
%  right=V .* m_r;
%  n1=sum(left(:)~=0);
%  n2=sum(right(:)~=0);
 
%  gr=max(n1,n2);
%  lo=min(n1,n2);
 
%  PATH_af='C:\mumu\data\all_patients\correcting_reg\new_exp_feature_based_p2\affected';
%  outputFileName = fullfile(PATH_af, ['subject_affected' num2str(1) '.nii']);
%  if n1>n2
%       
%       niftiwrite(left, outputFileName);
%  else
%       niftiwrite(right, outputFileName);
%  end
%  
%  
  
%   end
%   for i=1:19
%       l=L1(:,:,:,i);
%       path_f='C:\mumu\data\all_patients\correcting_reg\skull_free_test_case\skull_free1\zero_removed\skull_free\low-rank';
% outputFileName_avg = fullfile(path_f, ['low-rank' num2str(i) '.nii']);
% niftiwrite(l,outputFileName_avg);
%   end
% path_f='C:\mumu\data\all_patients\correcting_reg\sparse';
% outputFileName_avg = fullfile(path_f, ['sparse_ffold' num2str(89) '.nii']);
% niftiwrite(S1,outputFileName_avg);
% % outputFileName_avg = fullfile(path_f, ['low_ff' num2str(39) '.nii']);
% % niftiwrite(L1,outputFileName_avg);


%  
%  mip_L=max(L1,[],4);
 

 
%  mip_S=zeros(221,221,160);
% for num=1:NUM
% ss(:,:,:,num)=S1(:,:,:,num);
% mip_S=mip_S+ss(:,:,:,num);
% end
% mip_S=mip_S/19;
% 
%  niftiwrite(mip_S,'subject_finalsf6.nii')
% 
% 
% toc
% path_f='C:\mumu\data\all_patients\correcting_reg\after_calcification_without_blurring';
% outputFileName_avg = fullfile(path_f, ['subjectold_finalmip' num2str(89) '.nS1ii']);
% niftiwrite(mip_S,outputFileName_avg);
% 
% for num=1:NUM
% l(:,:,:,num)=L1(:,:,:,num);
% mip_L=mip_L+l(:,:,:,num);
% end
% path_f='C:\mumu\data\all_patients\correcting_reg\after_calcification_without_blurring';
% outputFileName_avg = fullfile(path_f, ['subject_finall' num2str(45) '.nii']);
% niftiwrite(mip_L,outputFileName_avg);

%   SliceBrowser(mip_S);
%   figure,SliceBrowser(mip_L),colormap(gray);
%  end