clear all;clc;close all; 
work_ori = cd;
pathname = uigetdir(); po = findstr(pathname,'\'); firstFoler = pathname(po(end)+1:end);
mkdir([work_ori],[firstFoler '_Squeeze'])
keep = 1;
datanumber = 0; INDEX = 0;
while keep == 1 
     

    %%%%%% Loading All Folder namd to Foldername variable %%%%%%%%%%%%%%%%
    cd(pathname);
    file = struct2cell(dir); file = file(1,:); 
    olddatanumber = datanumber;  datanumber = size(file,2);
    if datanumber == olddatanumber;    
        INDEX = INDEX + 1;
    else 
        INDEX = 0;
    end; 
    
    if INDEX == 3
        keep = 0; 
    end
    
    kk = 0;
    for i = 1 : length(file)
       index =  findstr(file{1,i},'.');
       if isempty(index) == 1
           kk = kk + 1;
           Foldername{kk,1} = file{1,i};     
           mkdir([work_ori '\' [firstFoler '_Squeeze']],[file{1,i}])
       end
    end
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     %%%%%% Start to squeeze all sensor file into one variable and save to
     %%%%%% another similar Folder 

        tic 
        i = 1;
    while i <= length(Foldername) 

        cd([pathname '\' Foldername{i,1}]);
        check = struct2cell(dir([pathname '\' Foldername{i,1} '\*.txt']));       yy = zeros(56,360000); 
        check2 = struct2cell(dir([pathname '\' Foldername{i,1} '\*.asc']));  
        judge = exist('judgeuse.mat','file');    
        if judge == 0 & isempty(check2) == 1; 
           pause(2);
                try
                    load('judgeuse');
                catch
                    judgeuse = 0; ; 
                    tt2 = toc;           
                    try
                        number = 0;
                        fprintf(['i = ' num2str(i) '/' num2str(length(Foldername)) ', Now Processing : ' Foldername{i,1} '\n'])   ; 

                        number = 0;
                        %%%%%%%%%%%%%%%%%%%%  Diff matlab control %%%%%%%%%%%%%%%%%%%%
                        if size(check,1) == 5
                            dirpo = 3;
                        else
                            dirpo = 4;
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
                        
                        parfor k = 1 : length(check) 
                            filename = check{1,k};
                            if  check{dirpo,k} == 6480000  
                                number = number + 1; 
                                y{k} = load(filename); 
                            end
                        end

                        for k = 1 : number
                            filename = check{1,k};
                            ii = str2num(filename(end-5:end-4));
                            yy(ii,:) = y{k};  
                        end 

                        nextCheck = 0;
                        while nextCheck == 0                     
                            if sum(sum(yy)) ~= 0 
                                 name = ['Squ_data_all']; name2 = [name '=yy']; evalc(name2);    
                                 cd([work_ori '\' firstFoler '_Squeeze' '\' Foldername{i,1}]);
                                 save(name,name);     clear Squ_data_all;
                                 pause(0.5);
                                try
                                    cd([work_ori '\' firstFoler '_Squeeze' '\' Foldername{i,1}])
                                    load('Squ_data_all');
                                    sum(Squ_data_all);
                                    nextCheck = 1;
                                    fprintf(['i = ' num2str(i) '/' num2str(length(Foldername)) ', ' Foldername{i,1} '-Folder Process Done ! \n'])
                                catch 
                                    fprintf(['Squeeze Data is corrupt, re-trying Again ! \n'])
                                end
                            else
                                nextCheck = 1;
                            end
                        end
                        t2 = toc;
                        cd([pathname '\' Foldername{i,1}]);
                        save('judgeuse','judgeuse')
                        fprintf(['i = ' num2str(i) '/' num2str(length(Foldername))  ', ' Foldername{i,1} ', ' num2str(i/length(Foldername)*100,'%0.2f') '(%%), ' 'SpendTime : ( ' num2str(t2,'%0.2f') ',' num2str(t2-tt2,'%0.2f') ' )\n'  ])

                        i = i + 1;
                    catch
                        error = 1 ; 
                        delete('judgeuse.mat')
                        fprintf(['Loading Data Error, re-trying Again ! \n'])
                    end   
                end
        else
            i = i + 1;
        end
    end
    
   fprintf(['Process completed, waitting 240 secend to countinue process next round   \n\n\n']);
    pause(120);
    
end




