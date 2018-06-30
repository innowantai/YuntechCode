clear all;clc;close all; 
work_ori = cd;
pathname = uigetdir(); po = findstr(pathname,'\'); firstFoler = pathname(po(end)+1:end);
mkdir([work_ori],[firstFoler '_Squeeze'])

%%%%%% Loading All Folder namd to Foldername variable %%%%%%%%%%%%%%%%
cd(pathname);
file = struct2cell(dir); file = file(1,:);
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
 
    
for i = 1:length(Foldername)
     Foldername{i,1}
%      pause(0.5);
    cd([pathname '\' Foldername{i,1}]);
    check = struct2cell(dir);     check = check(:,3:end);     yy = zeros(56,360000);
    judge = exist('judgeuse.mat','file');    
    if judge == 0;
        judgeuse = 0; save('judgeuse','judgeuse'); 
            tic   
            try
                parfor k = 1 : length(check)
                    index =  findstr(check{1,k},'txt'); 
                    filename = check{1,k};
                    if isempty(index) == 0 & check{3,k} == 6480000  
                        y{k} = load(filename); 
                    end
                end     
                for k = 1 : length(check)
                    filename = check{1,k};
                    ii = str2num(filename(end-5:end-4));
                    yy(ii,:) = y{k};  
                end
                if sum(sum(yy)) ~= 0
                    name = ['Squ_data_all']; name2 = [name '=yy']; evalc(name2);    
                    cd([work_ori '\' firstFoler '_Squeeze' '\' Foldername{i,1}]);
                    save(name,name); 
                    pause(2)
                end
            catch
            end    
         toc 
    end
end





