clear all;clc;close all;



[d1 d2 d3] = xlsread('地震資料.xlsx')

time = d3(:,2);
posi = d3(:,13);

kk = 0 ; 
for ii = 1 : 158
   index = posi{ii,1};
   if isnan(index) == 0
      kk = kk + 1
       data{kk,1} = time{ii,1};
       data{kk,2} = posi{ii,1};       
   end    
end

kk = 0;
for ii = 1 : size(data,1)
    index = data{ii,1}
    if isnan(index) == 0
        kk = kk + 1
       Data{kk,1} = data{ii,1};
       Data{kk,2} = data{ii,2};  
    end
end


Data = Data(2:end,:);

clear time;
for ii = 1 : size(Data,1)
    index = Data{ii,1};
    po = findstr(index,' ');
    time{ii,1} = index(1:po(1)-1);
    if index(po(1)+1:po(2)-1) == '上午'
        time{ii,2} = 0;
    else
        time{ii,2} = 12;
    end
    time{ii,3} = index(po(2)+1:end);
    time{ii,4} = index(po(1)+1:po(2)-1) ;
    
end


for ii = 1 : size(time,1)
    index1 = time{ii,1};
    index2 = time{ii,2};
    index3 = time{ii,3}; 
    
    po1 = findstr(index1,'/');
    year = index1(1:po1(1)-1);
    mon = index1(po1(1)+1:po1(2)-1);
    day = index1(po1(2)+1:end);
    
    po2 = findstr(index3,':');
    hh = str2num(index3(1:po2(1)-1)) + index2;
    mm = index3(po2(1)+1:po2(2)-1)
    ss = index3(po2(2)+1:end);
    
    if hh >= 24 ; hh = hh - 12 ;  end
    
     test2 = str2num(mm);
    if test2 <= 15
       mm = '00';
    elseif test2 <= 30
       mm = '15'      ;  
    elseif test2 <= 45
       mm = '30'    ;    
    else
       mm = '45';
    end
    if str2num(year) == 2016
    EqTime_2016All{ii,1} = [year num2str(str2num(mon),'%02d') num2str(str2num(day),'%02d') num2str(hh,'%02d') mm ]
    end
    
end

save('EqTime_2016All','EqTime_2016All')





