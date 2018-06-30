clear all;clc;close all;

work_ori = cd;
type = 'AB';

dt = 1/100;
n3 = 20;
iint = 80;
imax = 165;
wnrang = [0 5];
cutfn = [0 5];
span = 0.05;
Nc = 50;
modedet = 1;
SSI_result = ['ABSection'];
SSI_Figure = ['test'];
% SSI_result = ['2017_cutting'];
% SSI_Figure = ['2017_cutting'];
% SSI_result = ['2017_MoveTest'];
% SSI_Figure = ['2017_moveing']; 
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
end


Ax = [13 17 21 25];Ay = [14 18 22 26];Bx = [11 19 23 29];By = [12 20 24 30];Cx = [43 49 51];Cy = [44 50 42];Dx = [37 45 47 54];Dy = [38 46 48 55];
if type == 'AB'; sensor = [Ax Ay Bx By] ;elseif type == 'CD'; sensor = [Dx Dy Cx Cy];   end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
folderPath = pathname; 
plotOpen = 1
for ii = 1 :length(dataFolder)  
    path1 = [folderPath '\' dataFolder{ii}];
    file =struct2cell( dir([path1 '\*.mat']) );      file = file(1,:);   
    if plotOpen == 1 ;mkdir(folderPath,SSI_Figure); end ;  cd([path1 ]);      
    if isempty(file) == 0   ;   
        datename = dataFolder{ii};
        SSI_resultName = datename(1:16);
        SSI_resultName(findstr(SSI_resultName,'-')) = '_';  SSI_resultName(findstr(SSI_resultName,' ')) = '_';
        year = datename(1:4);       month = datename(6:7);       day = datename(9:10);       hour = datename(12:13);       mm = datename(15:16);
        if mm == '00';            minname= {'00' '15'};       elseif mm == '30';           minname = {'30' '45'};      end;
        %%%%%%%%%%%%%%%% Loading Data %%%%%%%%%%%%%%% 
        load('Squ_data_all');
        yy = Squ_data_all(sensor,:);
        yy = yy(:,1:2:end); 
        cd(work_ori);  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
        trdata = 0;
        for rr = 1 : 1 
            SSI_resultN = [type '_' SSI_result '_' minname{rr}];
            index2 = yy(:,1+trdata : 90000+trdata);                 trdata = trdata + 90000; 
            index = H_CuttintHis_sub(index2,dt,cutfn);
            cd([path1 '\' SSI_resultN ]);  
%             [dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang ] = ImSSI_withoutGUI(index,dt,n3,iint,imax,path1,SSI_resultN,wnrang); cd(work_ori);   
            load dt.txt;load Fin0.txt;load FYLimi.txt;load iint.txt;load imax.txt;load infn.txt;load inPHI_I.txt;load inPHI_R.txt;load inxi.txt;load wnrang.txt;
           cd(work_ori);  
            [ mode fnxi] = F_ThreeStepFilterUsing_sub(index,span,[dataFolder{ii} '-' minname{rr}],modedet,Nc,dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang,plotOpen,folderPath,SSI_Figure)
                       
            if type == 'AB'
                for i = 1 : size(fnxi,2);            
                    indexMode = mode{1,i};                          
                    result{1,i} = indexMode(:,1:4); 
                    result{2,i} = indexMode(:,5:8); 
                    result{3,i} = indexMode(:,9:12);   
                    result{4,i} = indexMode(:,13:16);  
                    result{5,i} = size(indexMode,1);                                
                    result{6,i} = fnxi(1,i);                                           
                    result{7,i} = fnxi(2,i);  
                end;           
            else
                
                for i = 1 : size(fnxi,2);
                    indexMode = mode{1,i};  
                    result{1,i} = indexMode(:,9:11); 
                    result{2,i} = indexMode(:,1:4);   
                    result{3,i} = indexMode(:,12:14);
                    result{4,i} = indexMode(:,5:8);  
                    result{5,i} = size(indexMode,1);                     
                    result{6,i} = fnxi(1,i);                    
                    result{7,i} = fnxi(2,i);        
                end;                      
            end
            F_PlotModeShapFigure_sub(result,type,dataFolder{ii},[folderPath '\' SSI_Figure '\'],[dataFolder{ii} '-' minname{rr}])
            name = ['alldata_' type '_' SSI_resultName '_' minname{rr}];    name2 = [name ' =  result']; evalc(name2);
            cd([folderPath '\' SSI_Figure]);  save(name,name) ;   cd(work_ori);                 
            fds
        end  
    end
    
    
end


