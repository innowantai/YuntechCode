clear all;clc;close all; 
work_ori = cd;
pathname = uigetdir(); po = findstr(pathname,'\'); firstFoler = pathname(po(end)+1:end);
% mkdir([work_ori],[firstFoler '_Squeeze'])
oriFolder = firstFoler(1:7);
%%%%%% Loading All Folder namd to Foldername variable %%%%%%%%%%%%%%%%
cd(pathname);
file = struct2cell(dir); file = file(1,:);
kk = 0;
for i = 1 : length(file)
   index =  findstr(file{1,i},'.');
   if isempty(index) == 1
       kk = kk + 1;
       Foldername{kk,1} = file{1,i};      
   end
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 kk = 0; kk2 = 0;
  for i = 1:length(Foldername)
    tic
    Foldername{i,1};
    cd([pathname '\' Foldername{i,1}]); 
    check = struct2cell(dir);    aa = -1;
    for ii = 1 : size(check,2)
        index = findstr(check{1,ii},'Squ_data_all');
        if isempty(index) ~= 1
            aa = check{3,ii};
        end
    end
     
    if aa == -1 
        kk = kk + 1;                   
        SquCheck{kk,1} = Foldername{i,1};     
        try       
%             delete([work_ori '\' oriFolder '\'  Foldername{i,1} '\'  'judgeuse.mat'])
        catch
        end
    elseif aa < 100525266
        kk2 = kk2 + 1;          
        SquError{kk2,1} = Foldername{i,1};   
      
        try
%             delete([work_ori '\' oriFolder '\'  Foldername{i,1} '\'  'judgeuse.mat'])
%             delete([work_ori '\' firstFoler '\' w Foldername{i,1} '\'  'Squ_data_all.mat'])
        catch
        end
    end 
toc
  end
 
 
  




