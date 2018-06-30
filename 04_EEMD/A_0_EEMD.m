clc; clear all;close all;

 

load('Noise')
  
ran = Noise(:,1:length(V));

PC = EEMD(V,Nstd,ran);
NC = EEMD(V,Nstd,-ran);
C2 = (PC + NC)/2;    


%     save([dataname{j} '_EEMD' num2str(Nstd) '_' num2str(noisenum) '.txt'],'C2','-ascii')
 