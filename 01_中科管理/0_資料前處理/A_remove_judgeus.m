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
%        mkdir([work_ori '\' [firstFoler '_Squeeze']],[file{1,i}])
   end
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %%%%%% Start to squeeze all sensor file into one variable and save to
 %%%%%% another similar Folder 
 
 cd(work_ori); 
 mkdir('0_remodeUsCandelete');
for i = 1:length(Foldername)
    cd([pathname '\' Foldername{i,1}]);
    check = struct2cell(dir);     check = check(:,3:end);     yy = zeros(56,360000);
    judge = exist('judgeuse.mat','file');    
    if judge ~= 0;
        movefile(['judgeuse.mat'],[work_ori '\0_remodeUsCandelete'])
    end 
end





