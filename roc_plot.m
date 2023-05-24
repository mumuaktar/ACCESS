clc;clear;
prefix_image='score_10_';
fileformat='.mat';
AUC=zeros(17,3);
AUC_avg=[];
for i=1:17
    load(strcat(prefix_image,num2str(i),fileformat));
%     load('score_nf_t5_11.mat')
%load scores
     score_log=t;
s=score_log(1:32);
load('labels.mat');
l=Y_f(1:32);
resp2=strcmp(l,'g');
[Xi,Yi,Ti,AUCi,OPTROCPTi] = perfcurve(resp2,s,1);
Ti((Xi==OPTROCPTi(1))&(Yi==OPTROCPTi(2)))
AUCi(AUCi<.50)=1-AUCi;
s=score_log(16:46);

l=Y_f(16:46);
resp2=strcmp(l,'i');
[Xp,Yp,Tp,AUCp,OPTROCPTp] = perfcurve(resp2,s,1);
Tp((Xp==OPTROCPTp(1))&(Yp==OPTROCPTp(2)))
AUCp(AUCp<.50)=1-AUCp;
s1=score_log(1:15);
s2=score_log(33:46);
ss=[s1;s2];
load('labels.mat');
l1=Y_f(1:15);
l2=Y_f(33:46);
ll=[l1;l2];
resp2=strcmp(ll,'p');
[Xg,Yg,Tg,AUCg,OPTROCPTg] = perfcurve(resp2,ss,1);
Tg((Xg==OPTROCPTg(1))&(Yg==OPTROCPTg(2)))
AUCg(AUCg<.50)=1-AUCg;
AUC(i,:)=[AUCg; AUCi; AUCp];
AUC_avg=[AUC_avg ((AUCi+AUCp+AUCg)/3)];

end
A=[AUC AUC_avg'];
  save('AUC_10.mat','A');
% figure
% plot(Yg,Xg)
% hold on
% plot(Xi,Yi)
% hold on
% plot(Xp,Yp)
% hold on
% plot(OPTROCPTi(1),OPTROCPTi(2),'ro')
% hold on
% plot(OPTROCPTg(1),OPTROCPTg(2),'ro')
% hold on
% plot(OPTROCPTp(1),OPTROCPTp(2),'ro')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clc;clear;
% load('fpr.mat')
% f=vect;
% f=f/46;
% load('tpr.mat')
% t=vect;
% t=t/46;
% figure(2),plot(t,f,'LineWidth',3,'DisplayName','ROC curve of Good Collaterals (AUC=90.95)')
% xlabel('False Positive Rate')
% ylabel('True Positive Rate')
% 
% hold on
% 
% load('fpr1.mat')
% f=vect;
% f=f/46;
% load('tpr1.mat')
% t=vect;
% t=t/46;
% figure(2),plot(f,t,'LineWidth',3, 'DisplayName','ROC curve of Intermediate Collaterals (AUC=83.53)')
% 
% hold on
% load('tpr2.mat')
% t=vect;
% t=t/46;
% load('fpr2.mat')
% f=vect;
% f=f/46;
% figure(2),plot(t,f,'LineWidth',3,'DisplayName','ROC curve of Poor Collaterals (AUC=81.70)')
% 
% hold on
% figure(2),plot([0, 1], [0, 1], 'k--');
% hold off
% lgd=legend();
% lgd.FontSize = 11;
