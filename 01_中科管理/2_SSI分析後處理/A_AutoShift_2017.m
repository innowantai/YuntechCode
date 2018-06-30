clear all;clc;close all; work_ori = cd;

year = 2017;
ClassType = 15;     %%%%% 設定為一個月為96點資料點 


pathname = uigetdir(); 

 
 

% type = 'CD';
type_ = {'AB' 'CD' };

for tttt = 1 : 2
    type = type_{tttt};
cd(work_ori)

if rem(year,4) ~= 0;    day_e = [31 28 31 30 31 30 31 31 30 31 30 31];else;    day_e = [31 29 31 30 31 30 31 31 30 31 30 31]    ;end;
if ClassType == 15 ; numberOfDay = 96; else ; numberOfDay = 48; end
if type == 'AB' ; CaseNum = 5 ; else CaseNum = 4;end
%%%%%%%%%%%% Part 1 : Loading All SSI-ThreeStep-filter result data %%%%%%%%%%%%%%%%%%%%
clear dataIndex; clear DateRecordindex; clear DateRecord;
if pathname ~= 0
    process = dir([pathname '\*.mat']);
    alldata = struct2cell(process);
    DateRecord = cell(1,size(alldata,2));
    k = 0;    
    for i = 1 : size(alldata,2);   
        index = findstr(alldata{1,i},type);   
        if isempty(index) == 0                                                  %%%% Change to zeros 
            k = k + 1;      dataIndex{k,1} =  alldata{1,i};   
            DateRecordindex = dataIndex{k,1};
            DateRecordindex = [DateRecordindex(12:25) DateRecordindex(29:30)];
            DateRecordindex(findstr(DateRecordindex,'_')) = '';
            DateRecord{1,k} = DateRecordindex;
        end;
    end;
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Part 2 : Shifting  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ po ] = F_Trans_DateToNumber_ForMonth_General(year,ClassType,DateRecord);
AllCase = length(dataIndex);
Fn_All = zeros(CaseNum,AllCase);
Xi_All = zeros(CaseNum,AllCase);
tic;  errori = 0;
for ii = 1 : AllCase
    try               
        cd(pathname);
        Fn = zeros(CaseNum,1); Xi = Fn;
        data_ = struct2cell(load(dataIndex{ii,1}));    data = data_{1}; cd(work_ori);
        index = cell2mat(data(6,:));
        [Mode  ] = A_UsingClassEachModeInformation(data,index,type);
        ModeNumber = find(Mode);
        CatchPosition = Mode(ModeNumber);
        Fn(ModeNumber,1) = cell2mat(data(6,CatchPosition))';
        Xi(ModeNumber,1) = cell2mat(data(7,CatchPosition))';
        Fn_All(1:size(Fn,1),ii) = Fn; 
        Xi_All(1:size(Fn,1),ii) = Xi;   
    catch
        errori = errori + 1;
        err(errori) = ii;  
    end
    t2 = toc;
    fprintf([ 'Type : ' type ', i = ' num2str(ii) ', ' num2str(ii/AllCase*100,'%0.2f') '(%%)' ', SpendTime = ' num2str(t2,'%0.2f') ' (Sec)' ', Error number :' num2str(errori)  '\n'])
end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%% Part 3 : After Processing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% month = str2num(pathname(end-1:end));  day = day_e(month);

postr = findstr(pathname,'\');
FolderName = [pathname(postr(end)+1:end) '_FilterResult'];   
month = str2num(pathname(postr(end)+1:postr(end)+2));  day = day_e(month);
Fn = zeros(CaseNum,day*numberOfDay);  Fn(:,po) = Fn_All;
Xi = zeros(CaseNum,day*numberOfDay);  Xi(:,po) = Xi_All;
work_out = pathname(1:postr(end)-1);
mkdir([work_out '\' FolderName]);                              
cd([work_out '\' FolderName])
AllData = [Fn' Xi'];  name = ['AllData_' type]; name2 = [name '=AllData']; evalc(name2);
save(name,name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end

  
