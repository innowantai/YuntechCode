clear all;clc;close all;
work_ori = cd;
 
SSI_Figure = ['SSI_FilterResultIndex_n10'];    


pathname = uigetdir();  
dataFolder = A_1_FolderProcessing_sub(pathname,SSI_Figure);

detName1 = ['SSI_check_n_10_AB.mat'];
detName2 = ['SSI_check_n_10_CD.mat'];
detName3 = ['ProcessDone_AB.mat'];
detName4 = ['ProcessDone_CD.mat'];



A_DeleteSSICheck_sub(pathname,dataFolder,detName1)
A_DeleteSSICheck_sub(pathname,dataFolder,detName2)
A_DeleteSSICheck_sub(pathname,dataFolder,detName3)
A_DeleteSSICheck_sub(pathname,dataFolder,detName4) 

for ii = 0:3
    detName5 = ['AB_Section_n10_' num2str(15*ii,'%02d')]; 
    A_DeleteSSIFolder_sub(pathname,dataFolder,detName5)
    detName6 = ['CD_Section_n10_' num2str(15*ii,'%02d')]; 
    A_DeleteSSIFolder_sub(pathname,dataFolder,detName6)
end



