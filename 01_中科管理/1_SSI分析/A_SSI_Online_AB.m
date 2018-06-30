clear all;clc;close all;

work_ori = cd;
type = 'AB'




dt = 1/100;
n3 = 10;
iint = 85;
imax = 165;00
wnrang = [0 5];
cutfn = [0.3 5];
span = 0.05;
Nc = 50;
modedet = 1;
plotOpen = 0;
Ax = [13 17 21 25];Ay = [14 18 22 26];Bx = [11 19 23 29];By = [12 20 24 30];Cx = [43 49 51];Cy = [44 50 52];Dx = [37 45 47 54];Dy = [38 46 48 55];
if type == 'AB'; sensor = [Ax Ay Bx By] ;elseif type == 'CD'; sensor = [Dx Dy Cx Cy];   end; 
SSI_result = ['Section_n10'];
SSI_Figure = ['SSI_FilterResultIndex_n10'];    
datename = datestr(now); datename(findstr(datename,':')) = '-'; Error_name = ['Error Report ' datename '.txt'];

error_iter = 1; 


pathname = uigetdir();  
folderPath = pathname;   
mkdir(folderPath,SSI_Figure)


kk = 0;oldll = -1;
while 1
    cd(work_ori)
    dataFolder = A_1_FolderProcessing_sub(pathname,SSI_Figure);
    ll = length(dataFolder);
    
    if ll == oldll & kk == 2;   
        kk = 0;
    elseif ll == oldll 
        kk = kk + 1; 
        dataFolder = dataFolder(1:end-1);
    else
        dataFolder = dataFolder(1:end-1);
    end
     
    A_2_AnalysicPart_sub(dataFolder,folderPath,type,SSI_result,sensor,wnrang,cutfn,dt,n3,iint,imax,modedet,Nc,span,SSI_Figure,plotOpen)
    
    
    oldll = ll;
    
    pause(120)
 
  
    
end




