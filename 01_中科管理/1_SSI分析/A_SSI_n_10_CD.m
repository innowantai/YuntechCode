clear all;clc;close all;

work_ori = cd;
type = 'CD'

dt = 1/100;
n3 = 10;
iint = 85;
imax = 165;
wnrang = [0 5];
cutfn = [0.3 5];
span = 0.05;
Nc = 50;
modedet = 1;

plotOpen = 0;

SSI_result = ['Section_n10'];
SSI_Figure = ['SSI_FilterResultIndex_n10'];
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
error_iter = 1; tic;
for ii = 1 :length(dataFolder)   
    error_open = 0;
    path1 = [folderPath '\' dataFolder{ii}];
    file =struct2cell( dir([path1 '\*Squ_data_all.mat']) );      file = file(1,:);        cd(path1);   
    namecheck = ['SSI_check_n_10_' type ];     SSIcheck = exist([namecheck '.mat'],'file');
    if isempty(file) == 0  & SSIcheck == 0 ;   
        %%%%%% This variable is using to check whether do analysis %%%%%
        namecheck2 = [namecheck '=0'];    evalc(namecheck2);save(namecheck,namecheck);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        datename = dataFolder{ii};
        SSI_resultName = datename(1:16);
        SSI_resultName(findstr(SSI_resultName,'-')) = '_';  SSI_resultName(findstr(SSI_resultName,' ')) = '_';
        year = datename(1:4);       month = datename(6:7);       day = datename(9:10);       hour = datename(12:13);       mm = datename(15:16);
        if mm == '00';            minname= {'00' '15'};       elseif mm == '30';           minname = {'30' '45'};      end;
        
        try 
            %%%%%%%%%%%%%%%% Loading Data %%%%%%%%%%%%%%% 
            load('Squ_data_all');        yy = Squ_data_all(sensor,:);         yy = yy(:,1:2:end);          cd(work_ori);  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
            trdata = 0; 
            tt1 = toc;
            for rr = 1 : 2
                datename(15:16) = minname{rr};
                fprintf(['i = ' num2str(ii*2-2+rr) '/' num2str(length(dataFolder)*2) ', Now Processing : ' type ' - ' datename  '\n']);
                SSI_resultN = [type '_' SSI_result '_' minname{rr}];            mkdir(path1,SSI_resultN); 
                trdata = 90000*(rr-1) ;           index2 = yy(:,1+trdata : 90000+trdata);           
                if min(sum(index2')) == 0;                   asdasd ;                end;
                index = H_CuttintHis_sub(index2,dt,cutfn);
                index = index(:,200:end-200+1);
                [dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang ] = ImSSI_withoutGUI(index,dt,n3,iint,imax,path1,SSI_resultN,wnrang); cd(work_ori);   
                [ mode fnxi max_ave] = F_ThreeStepFilterUsing_sub(index,span,[dataFolder{ii} '-' minname{rr}],modedet,Nc,dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang,plotOpen,folderPath,SSI_Figure);

               if type == 'AB'
                    iter = 0;     
                    
                    for i = 1 : size(fnxi,2);            indexMode = mode{1,i};                if size(indexMode,1) > 12  ;    iter = iter + 1;         result{1,iter} = indexMode(:,1:4);  result{3,iter} = indexMode(:,5:8); result{2,iter} = indexMode(:,9:12);       result{4,iter} = indexMode(:,13:16);    result{5,iter} = size(indexMode,1);         result{6,iter} = fnxi(1,i);     result{7,iter} = fnxi(2,i);  ;     result{8,iter} = max_ave(i,1); end;  end;           
               else
                    iter = 0;           for i = 1 : size(fnxi,2);      indexMode = mode{1,i};             if size(indexMode,1) > 12; iter = iter + 1; result{1,iter} = indexMode(:,9:11);    result{2,iter} = indexMode(:,1:4);    result{3,iter} = indexMode(:,12:14);  result{4,iter} = indexMode(:,5:8);   result{5,iter} = size(indexMode,1);     result{6,iter} = fnxi(1,i);      result{7,iter} = fnxi(2,i); result{8,iter} = max_ave(i,1);   end;end;                      
               end
                F_PlotModeShapFigure_sub(result,type,dataFolder{ii},[folderPath '\' SSI_Figure '\'],[dataFolder{ii} '-' minname{rr}],plotOpen);
                name = ['alldata_' type '_' SSI_resultName '_' minname{rr}];    name2 = [name ' =  result']; evalc(name2);
                cd([folderPath '\' SSI_Figure]);  save(name,name) ;   cd(work_ori);             tt2 = toc;
               fprintf(['i = ' num2str(ii*2-2+rr) '/' num2str(length(dataFolder)*2) ', ' num2str((ii*2-2+rr)/length(dataFolder)/2*100,'%0.2f') ' (%%), ' 'Processing Done!, SpendTime : ( ' num2str(tt2-tt1,'%0.2f') ',' num2str(tt2,'%0.2f') ' ) \n' ])

               clear result;
            end  
            cd(path1); nameDone = ['ProcessDone_' type];   nameDone2 = [nameDone '=0']; evalc(nameDone2); save(nameDone,nameDone); cd(work_ori);     
        
        catch            
                %%%%%%%%%% DataLength Error Record %%%%%%%%%%%%%%%%%%%%
                error_open = 1; textFile = [num2str(error_iter) '.資料夾 ' dataFolder{ii} '訊號有問題']; 
                fprintf(['The Folder : ' datename ' signal error !, Cant analysis \n' ])
       
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
         
        
         if error_open == 1;   cd(work_ori);  error_iter = error_iter + 1;  fid = fopen(Error_name,'a');  fprintf(fid,'%s \n',textFile );  fclose(fid);  end
         
    end        
end



