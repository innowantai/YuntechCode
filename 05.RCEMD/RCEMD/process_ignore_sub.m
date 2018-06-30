function [maxima2  minimum2 safe]=process_ignore_sub(maxima,minimum,v,index1,safe,lm,ln,delta)

ll2=length(v); compare1=0; compare2=0; com1=zeros(1,min([lm ln])-2); com2=zeros(1,min([lm ln])-2);
 
if maxima(1,2) > minimum(1,2)
    for i=2:min([lm ln])-1
        compare1=abs(maxima(1,i)-minimum(1,i));
        compare2=abs(maxima(1,i)-minimum(1,i+1));
        com1(i-1)=compare1;
        com2(i-1)=compare2;
         if i==2 & compare1 <=index1 & minimum(1,2)<=10
             minimum(1,2)=0;
             
         elseif i==min([lm ln])-1 & compare1 <=index1 & ll2 - max([maxima(1,lm-1) minimum(1,ln-1)]) <=10
             if maxima(1,lm-1) > minimum(1,ln-1)
                 maxima(1,lm-1)=0;                                   
             else
                 minimum(1,ln-1)=0;
             end
             
         elseif compare1 == compare2 & compare1 <= index1
            maxima(1,i) = 0;
            if minimum(1,i) < minimum(1,i+1)
               minimum(1,i+1)=0;
            else
                minimum(1,i)=0;
            end
            
         elseif compare1 <= index1
             maxima(1,i)=0;
             minimum(1,i)=0;             
         elseif  compare2 <= index1 
             maxima(1,i)=0;
             minimum(1,i+1)=0;                
         end       
    end    
else
    for i=2:min([lm ln])-1
        compare1=abs(minimum(1,i)-maxima(1,i));
        compare2=abs(minimum(1,i)-maxima(1,i+1));
        com1(i-1)=compare1;
        com2(i-1)=compare2;

        if i==2 & compare1 <= index1 & maxima(1,2)<=10
            maxima(1,2)=0;          
             
        elseif i==min([lm ln])-1 & compare1 <=index1 & ll2 - max([maxima(1,lm-1) minimum(1,ln-1)]) <=10
             if maxima(1,lm-1) > minimum(1,ln-1)
                 maxima(1,lm-1)=0;                 
             else
                 minimum(1,ln-1)=0;
             end
             
        elseif compare1 == compare2 & compare1 <= index1
            minimum(1,i) = 0;
            if maxima(1,i) < maxima(1,i+1)
               maxima(1,i)=0;
            else
                maxima(1,i+1)=0;
            end
            
         elseif compare1 <= index1 
             maxima(1,i)=0;
             minimum(1,i)=0;             
        elseif  compare2 <= index1 
             maxima(1,i+1)=0;
             minimum(1,i)=0;
         end
    end          
        
    
end 
%%%%%% Useing to prevent infinite roop %%%%%
if min([com1 com2]) ~= index1,safe=0; end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Processing ignore local extrema point %%%
k1=0;
for i=1:lm
   if maxima(1,i)~=0
     k1=k1+1; maxima2(1,k1)=maxima(1,i); maxima2(2,k1)=maxima(2,i);
   end
end

k2=0;
for i=1:ln
    if minimum(1,i)~=0
       k2=k2+1; minimum2(1,k2)=minimum(1,i); minimum2(2,k2)=minimum(2,i);        
    end
end
 

 