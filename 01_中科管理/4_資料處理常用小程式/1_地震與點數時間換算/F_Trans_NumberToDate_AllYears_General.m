function po = F_Trans_NumberToDate_AllYears_General(year,CaseName,testff)

 
if rem(year,4) == 0
    day_ = [31 29 31 30 31 30 31 31 30 31 30 31];  
else
    day_ = [31 28 31 30 31 30 31 31 30 31 30 31];
end

testff = sort(testff);
if CaseName == 15
number_OfDay = 96; m_ = [45 0 15 30];
else
number_OfDay = 48; m_ = [30 0];
end
po = [];
for i = 1 : length(testff)
    
    month = 1 ;
    index = testff(i);    
    Check = isempty(index);
    
    if Check == 1
        
       po = [];
       
    else
        
        while index > day_(month)*number_OfDay
               index = index - day_(month)*number_OfDay;
               month = month + 1 ;   
         end
    
        month_len = index;
        day = ceil(month_len/number_OfDay) ;

        count_unit_day = rem(month_len,number_OfDay);

        if CaseName == 15            
            mi = rem(count_unit_day,4) + 1;
            mm = m_(mi);
            if rem(count_unit_day,96)~=0;    hour = ceil(rem(count_unit_day,number_OfDay)/4)-1;   else;    hour = 23;end ;
        else
            mi = rem(count_unit_day,2) + 1;
            mm = m_(mi);
            if rem(count_unit_day,48)~=0;    hour = ceil(rem(count_unit_day,number_OfDay)/2)-1;   else;    hour = 23;end ;            
        end
        
        temp = [num2str(year) num2str(month,'%02d') num2str(day,'%02d') num2str(hour,'%02d') num2str(mm,'%02d')];
        po{i,1} = temp;        
        
        
        
    end
    
    
end
