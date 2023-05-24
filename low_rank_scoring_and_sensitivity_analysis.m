
clc;clear;


fileformat='.nii';
prefix_image='subject';
pr='vessel';
D4=[];
NUM=8;
threshold_set=[];
 addpath(genpath("C:\mumu\data\all_patients\sensitivity analysis\test_for_t5"));
score_all=[];
load binary
test_path='C:\mumu\data\all_patients\sensitivity analysis\test_for_t5';

total=46;
T = zeros(1,total);

 for n=1:total
                
         s1=niftiread(strcat(pr,num2str(n),fileformat));


         for num=1:NUM
                if num~=8
                    s=niftiread(strcat(prefix_image,num2str(num),fileformat));

                    s=im2double(s);
                    s(s<0)=0;
%                            
%                            I=s;
%                            I = I - min(I(:));
%                            I = I / prctile(I(I(:) > 0.5 * max(I(:))),90);
%                            I(I>1) = 1;
%                            V = vesselness3D(I, .5:.5:2.5, [2;2;2], .8, true);
%                            V=imgaussfilt3(V,2.1); 
                    V=s;
                           
                else
%                    
                      s=s1;
                      V=s;

                      V=imgaussfilt3(V,2.1);    

                      qq1=max(V,[],3);

                end


        im=reshape(V,221*221*160,1);
        D4=[D4 im];

        end
 % D=double((D4-min(D4(:)))./250/(max(D4(:))-min(D4(:))));
 D=im2double(D4);
 
 tic 
 [A, ~ ] = InfaceExtFrankWolfe(D, .4,0, 10);
 
 T(n)=toc;
%   E = abs(A - D);
   E = A-D;
   E(E<0)=0;
% [A_hat E_hat iter] = inexact_alm_rpca(D);
 S1=reshape(E,221,221,160,8);
 L1=reshape(A,221,221,160,8);
 S1(S1<0)=0;
 L1(L1<0)=0;
 aa=S1(:,:,:,8);
 aa(aa<0)=0;

 bb=L1(:,:,:,8);
 bb(bb<0)=0;

 aaa=max(aa,[],3);

 bbb=max(bb,[],3);
%   noise=0;
   noise=40;
  score_in=[];
 for th=.01:.005:.09
%  figure,imagesc(aaa),colormap(gray)
%   figure,imagesc(bbb),colormap(gray)
    qq2=imbinarize(qq1);
 % a1=imbinarize(aaa,.06);
    a1=imbinarize(aaa,th);


    a1(qq2)=0;
    a1(binaryImage)=0;
 %figure,imagesc(a1),colormap(gray)

    a1 = bwareaopen(a1, noise);
% figure,imagesc(a1),colormap(gray)
% b1=imbinarize(bbb,.08);
    b1=imbinarize(bbb,(th+.02));
    b1(binaryImage)=0;

    n=sum(a1(:));
    n1=sum(b1(:));
    r=n/n1;
    s=1-r;
    score_in=[score_in s];
%  PATH='C:\mumu\data\all_patients\sensitivity analysis\poor_score';
%   outputFileName = fullfile(PATH, ['score_poor' num2str(k) '.mat']);
%  save(outputFileName,'score_in');
% threshold_set=[threshold_set th];
  end

score_all=[score_all score_in'];

D4=[];
 end
avg_time=sum(T)/46;
PATH='C:\mumu\data\all_patients\sensitivity analysis';
outputFileName = fullfile(PATH, 'score_for_.40.mat');
%  save(outputFileName,'score_in');
save(outputFileName,'score_all');

