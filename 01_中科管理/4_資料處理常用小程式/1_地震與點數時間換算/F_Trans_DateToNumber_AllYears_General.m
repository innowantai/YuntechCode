function  [ result] = F_Trans_DateToNumber_AllYears_General(year,CaseName,po)



if rem(year,4) == 0
    day_ = [31 29 31 30 31 30 31 31 30 31 30 31];  
else
    day_ = [31 28 31 30 31 30 31 31 30 31 30 31];
end

if CaseName == 15
   day_iter = 96;
   h_iter = 4;
else
   day_iter = 48;
   h_iter = 2;    
end

for i = 1 : length(po)
    index = po{i};
    if isempty(index) == 0
    year = index(1:4);    month = index(5:6);    day = index(7:8);    hr = index(9:10);    min = index(11:12);

    if str2num(month) > 2
        number1 = sum(day_(1:str2num(month)-1))*day_iter;
    elseif str2num(month) ==2
        number1 = 31*day_iter;
    elseif str2num(month) == 1
        number1 = 0 ;
    end

    number2 = (str2num(day)-1)*day_iter;
    number3 = (str2num(hr))*h_iter;
    
    if CaseName == 15    
        if str2num(min) == 45
            number4 = 4;
        elseif str2num(min) == 30
            number4 = 3;        
        elseif str2num(min) == 15
            number4 = 2;
        else
            number4 = 1;
        end
    else   
        if str2num(min) == 30
            number4 = 2; 
        else
            number4 = 1;
        end
        
    end
    
    
    number = [number1 + number2 + number3 + number4];
    result(i,1) = number ;
    end
end