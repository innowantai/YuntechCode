clear all;clc;close all;

work_ori = cd;
type = 'AB';

dt = 1/100;
n3 = 20;
iint = 85;
imax = 165;
wnrang = [0 5];
cutfn = [0 5];
span = 0.05;
Nc = 50;
modedet = 1;

plotOpen = 0
SSI_result = ['Section'];
SSI_Figure = ['SSI_FilterResultIndex'];
datename = datestr(now); datename(findstr(datename,':')) = '-'; Error_name = ['Error Report ' datename '.txt'];
pathname = uigetdir(); 
if pathname ~= 0
    process = dir([pathname ]);
    alldata = struct2cell(process);
    k = 0;    
    for i = 1 : size(alldata,2);   
        index = findstr(alldata{1,i},'.');   
        if isempty(index) == 1 & strcmp(alldata{1,i},SSI_Figure) ~= 1;     
            k = k + 1;      dataFolder{k,1} =  alldata{1,i};  
        end;
    end;
end;
 
Ax = [13 17 21 25];Ay = [14 18 22 26];Bx = [11 19 23 29];By = [12 20 24 30];Cx = [43 49 51];Cy = [44 50 52];Dx = [37 45 47 54];Dy = [38 46 48 55];
if type == 'AB'; sensor = [Ax Ay Bx By] ;elseif type == 'CD'; sensor = [Dx Dy Cx Cy];   end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
folderPath = pathname;   
mkdir(folderPath,SSI_Figure)
error_iter = 1; kk = 0;kk2 = 0; 
for ii = 1 :length(dataFolder)  
    error_open = 0;
    path1 = [folderPath '\' dataFolder{ii}]
    file =struct2cell( dir([path1 '\*Squ_data_all.mat']) );      file = file(1,:);        cd(path1);  
    namecheck = ['SSI_check_' type ];     SSIcheck = exist([namecheck '.mat'],'file');
    if  SSIcheck == 2
        delete([path1 '\' namecheck '.mat']) 
        kk = kk + 1;
%         index{kk,1} = dataFolder{ii};
    end        
     
    
    namecheck = ['ProcessDone_' type ];     SSIcheck = exist([namecheck '.mat'],'file');
    if  SSIcheck == 2
        delete([path1 '\' namecheck '.mat']) 
        k2k = kk2 + 1;
%         index{kk2,1} = dataFolder{ii};
    end        
    
    
    
end


