clc; clear all
clear all;clc;close all; 
work_ori = cd;
pathname = uigetdir(); po = findstr(pathname,'\'); firstFoler = pathname(po(end)+1:end);
% mkdir([work_ori],[firstFoler '_Squeeze'])
% oriFolder = firstFoler(1:7);

ct = 1;
iter = 0;  error  = 0;
while ct
    
  
try
    
     
%%%%%% Loading All FolderName to Foldername variable %%%%%%%%%%%%%%%%
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
     for ii = 1 : size(Foldername,1)
         Folderindex = Foldername{ii,1};
         fprintf(['ii = ' num2str(ii) '/' num2str(size(Foldername,1)) ' Processing Folder : ' Folderindex '\n']);
         cd([pathname '\' Folderindex]); 
         index = struct2cell(dir);
         index = index(:,3:end);
         open = 0; kk = 0;
         for i = 1 : size(index,2)
             ch1 = findstr(index{1,i},'asc');
             if isempty(ch1) ~= 1  
                 kk = kk + 1;
                 fileindex{kk,1} = index{1,i};
                 open = 1;
             end
         end
         if open == 1
             try
                yy = zeros(1,length(fileindex));tic
                fprintf(['     Loading All Acsii data ... ''\n']);
                 for i = 1 : length(fileindex)    
                     filename2 = fileindex{i,1};  
                     filename3 = filename2;
                     filename3(findstr(filename3,'asc'):end) = 'txt'; 
                     fid = fopen([filename2]);
                     InputText = textscan(fid, '%s', 3, 'delimiter', 'n'); % 讀取標題列 
                     Data = textscan(fid, '%f'); % 讀取資料區塊 
                     data = (Data{1});  t = data(1:2:end);  y = data(2:2:end);
                     yy(1:length(y),i) = y;
                     fclose(fid); 
                 end  

                fprintf(['     Saving data to text type ... ''\n']);
                 for i = 1 : length(fileindex)
                     y = yy(:,i);
                     filename2 = fileindex{i,1};     filename3 = filename2;
                     filename3(findstr(filename3,'asc'):end) = 'txt';  
                     save(filename3,'y','-ascii');  
                 end         

                fprintf(['     deleting All Acsii type data ... ''\n']);
                 for i = 1 : length(fileindex)    
                     filename2 = fileindex{i,1};   
                     delete([filename2]); 
                 end

                fprintf(['ii = ' num2str(ii) '/' num2str(size(Foldername,1))  ' Process Folder : ' Folderindex ' done ! \n']);
% try
             catch
                error = error + 1;
                err{error} = [' The Folder : ' Folderindex ' File is too small, process error !!'];
                fprintf([' The Folder : ' Folderindex 'File is too small, process error !!' ' done ! \n']);
             end
           
         end
     end
   
 
 if iter ~= 0 & size(Foldername,1) == size(oldcheck,1);
     iter = iter + 1;
     oldcheck = Foldername; 
 elseif iter == 0;
     oldcheck = Foldername; 
     iter = iter + 1;
 else
     iter = 0;
 end; 

if iter == 5;    ct = 0; end;


% try
catch  
    
end
fprintf(['Process completed, waitting 120 secend to countinue process next round   \n\n\n']);
pause(120)  
end
fprintf(['All data process done !!  \n']);
