function [ preProcess ] = A_SSIResult_sub(pathname,type)
 

work_ori = cd;
 
a = struct2cell(dir([pathname '\*.mat']));  file = a(1,:);
dayAll = [31 28 31 30 31 30 31 31 30 31 30 31];
kk = 0;
for i = 1 : size(a,2)
    index = file{1,i}; 
    if isempty(findstr(index,type)) == 0
        kk = kk + 1;
        year = index(12:15);        month = index(17:18);        day = index(20:21);        hr = index(23:24);        mi = index(29:30);
        dateindex = [year month day hr mi];        dataIndex{kk,1} = dateindex; 
    end
end
data = zeros(dayAll(str2num(month))*96,1);
[ result ] = F_Trans_DateToNumber_ForMonth_General(2016,15,dataIndex);
data(result) = 1;
noResult = find(data==0);
noResultDate = F_Trans_NumberToDate_ForMonth_General(str2num(year),str2num(month),15,noResult);

for ii = 1 : size(noResultDate,1)
    index = noResultDate{ii,1};
    year = index(1:4);
    month = index(5:6);
    day = index(7:8);
    hr = index(9:10);
    mi = index(11:12);
    if mi == '15'
        preProcess{ii,1} = [year '-' month '-' day ' ' hr '-00'  '-00' ' (1)' ];
        preProcess{ii,2} = 2       ;
    elseif mi == '45'
        preProcess{ii,1} = [year '-' month '-' day ' ' hr '-30'  '-00' ' (1)' ];
        preProcess{ii,2} = 2;
    else
        preProcess{ii,1} = [year '-' month '-' day ' ' hr '-' mi '-00' ' (1)' ];
        preProcess{ii,2} = 1       ;        
    end
       
    
end








