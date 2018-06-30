function [maxima,minimum,openl,openr,exML]=boundcondition(maxima1,minimum1,x,r)
maxima=maxima1;
minimum=minimum1;
Lmax=length(maxima);
Lmin=length(minimum);
ll=length(r);
open1=0;open2=0;open3=0;open4=0;open5=0;open6=0;open7=0;open8=0;
exML=maxima(2,1);exNL=minimum(2,1);exMR=maxima(2,Lmax);exNR=minimum(2,Lmin);
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
judge_s =2;   %%%% ¤£¥Î§ï
extrema_point = 10 ;   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



if length(maxima)>=4
exML=interp1(maxima(1,2:3),maxima(2,2:3),x(1,1),'linear','extrap');
exMR=interp1(maxima(1,(Lmax-2:Lmax-1))  ,maxima(2,(Lmax-2:Lmax-1)),  x(1,length(x)),'linear','extrap');

lomax = max([maxima(2,1:Lmax)]);
dx1=maxima(1,2)-maxima(1,1);
dx2=maxima(1,3)-maxima(1,2);
dx3=maxima(1,Lmax)-maxima(1,Lmax-1);
dx4=maxima(1,Lmax-1)-maxima(1,Lmax-2);

if dx1 > dx2 
    posi1=ceil((maxima(1,2)+minimum(1,1))/2);
    if posi1 ~= maxima(1,2) & posi1 ~= minimum(1,2)
         open1=1;
    end
end

if exML > lomax
    posi1=ceil((maxima(1,2)+minimum(1,1))/2);
    if posi1 ~= maxima(1,2) & posi1 ~= minimum(1,2)
         open2=1;
    end
end


   

if dx3 > dx4  
    posi1=floor((maxima(1,Lmax-1)+minimum(1,Lmin))/2);
    if posi1 ~= maxima(1,Lmax-1) & posi1 ~= minimum(1,Lmin-1)
      open5=1;
    end
    
end

if  exMR > lomax
    posi1=floor((maxima(1,Lmax-1)+minimum(1,Lmin))/2);
    if posi1 ~= maxima(1,Lmax-1) & posi1 ~= minimum(1,Lmin-1)
      open6=1;
    end
    
end

 
 

end

if length(minimum)>=4
    exNL=interp1(minimum(1,2:3),minimum(2,2:3),x(1,1),'linear','extrap');
    exNR=interp1(minimum(1,(Lmin-2:Lmin-1)),minimum(2,(Lmin-2:Lmin-1)),x(1,length(x)),'linear','extrap');

lomin = min(minimum(2,1:Lmin));
dx1=minimum(1,2)-minimum(1,1);
dx2=minimum(1,3)-minimum(1,2);
dx3=minimum(1,Lmin)-minimum(1,Lmin-1);
dx4=minimum(1,Lmin-1)-minimum(1,Lmin-2);


if dx1 > dx2 
     posi1=ceil((maxima(1,2)+minimum(1,1))/2);
    if posi1 ~= maxima(1,2) & posi1 ~= minimum(1,2)
        open3=1;
    end
end

if  exNL < lomin
     posi1=ceil((maxima(1,2)+minimum(1,1))/2);
    if posi1 ~= maxima(1,2) & posi1 ~= minimum(1,2)
        open4=1;
    end
end
 


if dx3 > dx4   
    posi1=floor((maxima(1,Lmax-1)+minimum(1,Lmin))/2);
    if posi1 ~= maxima(1,Lmax-1) & posi1 ~= minimum(1,Lmin-1)
      open7=1;
    end
end    

if  exNR < lomin
    posi1=floor((maxima(1,Lmax-1)+minimum(1,Lmin))/2);
    if posi1 ~= maxima(1,Lmax-1) & posi1 ~= minimum(1,Lmin-1)
      open8=1;
    end
end  

  
 

end

if  Lmax+Lmin < extrema_point
    open1=0;open2=0;open3=0;open4=0;
    open5=0;open6=0;open7=0;open8=0;
 
end

if  open1+open2 >= judge_s | open3+open4 >= judge_s
    Lmax=length(maxima);
    Lmin=length(minimum);
    if maxima(1,2) < minimum(1,2)        
       posi1=ceil((maxima(1,2)+minimum(1,1))/2);
       
       if posi1~=maxima(1,2)
        maxima2=r(posi1);
        minimum2=r(posi1);     
        old1=maxima(:,1);
        old2=minimum(:,1);
        test1=[posi1;maxima2];
        test2=[posi1;minimum2];
        maxima(:,1)=test1;
        minimum(:,1)=test2;
        maxima=[old1 maxima];
        minimum=[old2 minimum];
        
        maxima(2,1)=r(1);
        minimum(2,1)=r(1);
       else
           open1=0;open2=0;open3=0;open4=0;
 
       end
       
         
    else
        posi1=ceil((maxima(1,1)+minimum(1,2))/2);
        if posi1 ~= minimum(1,2)
        maxima2=r(posi1);
        minimum2=r(posi1);    
        old1=maxima(:,1);
        old2=minimum(:,1);
        test1=[posi1;maxima2];
        test2=[posi1;minimum2];
        maxima(:,1)=test1;
        minimum(:,1)=test2;
        maxima=[old1 maxima];
        minimum=[old2 minimum];
        
         maxima(2,1)=r(1);
        minimum(2,1)=r(1);
        else
            open1=0;open2=0;open3=0;open4=0;
 
        end
        
        
    end
end



if open5+open6 >= judge_s | open7+open8 >= judge_s
    
    Lmax=length(maxima);
    Lmin=length(minimum);
    if maxima(1,Lmax-1) > minimum(1,Lmin-1)
        posi1=floor((maxima(1,Lmax-1)+minimum(1,Lmin))/2);
        if posi1 ~= maxima(1,Lmax-1)
        maxima2=r(posi1);
        minimum2=r(posi1);
        maxima(1,Lmax+1)=maxima(1,Lmax);
        maxima(2,Lmax+1)=maxima(2,Lmax);
        minimum(1,Lmin+1)=minimum(1,Lmin);
        minimum(2,Lmin+1)=minimum(2,Lmin);
        maxima(1,Lmax)=posi1;
        maxima(2,Lmax)=maxima2;
        minimum(1,Lmin)=posi1;
        minimum(2,Lmin)=maxima2;
                 
       
        else
 
open5=0;open6=0;open7=0;open8=0;
            
        end
        
        
    else
        posi1=floor((maxima(1,Lmax)+minimum(1,Lmin-1))/2);
        if posi1 ~= minimum(1,Lmin-1)
        maxima2=r(posi1) ;
        minimum2=r(posi1);
        maxima(1,Lmax+1)=maxima(1,Lmax);
        maxima(2,Lmax+1)=maxima(2,Lmax);
        minimum(1,Lmin+1)=minimum(1,Lmin);
        minimum(2,Lmin+1)=minimum(2,Lmin);
        maxima(1,Lmax)=posi1;
        maxima(2,Lmax)=maxima2
        minimum(1,Lmin)=posi1;
        minimum(2,Lmin)=maxima2;
         
         
        else
 
            
open5=0;open6=0;open7=0;open8=0;
        end
 
      
    end
    
end



Lmax=length(maxima);Lmin=length(minimum);
if Lmax >4
exML=interp1(maxima(1,2:3),maxima(2,2:3),x(1,1),'linear','extrap');
exMR=interp1(maxima(1,(Lmax-2:Lmax-1))  ,maxima(2,(Lmax-2:Lmax-1)),  x(1,length(x)),'linear','extrap');
end
if Lmin > 4
exNL=interp1(minimum(1,2:3),minimum(2,2:3),x(1,1),'linear','extrap');
exNR=interp1(minimum(1,(Lmin-2:Lmin-1)),minimum(2,(Lmin-2:Lmin-1)),x(1,length(x)),'linear','extrap');
end

maxima(2,1)=r(1);minimum(2,1)=r(1);maxima(2,Lmax)=r(ll);minimum(2,Lmin)=r(ll);

if open1+open2< judge_s & open3+open4 < judge_s
             if  maxima(2,1)<exML
               maxima(2,1)=exML;
           end
            
            if minimum(2,1)>exNL
              minimum(2,1)=exNL;
           end
end

if open5+open6< judge_s & open7+open8 < judge_s
            if maxima(2,length(maxima))<exMR
                 maxima(2,length(maxima))=exMR;    
                end
            if minimum(2,length(minimum))>exNR
               minimum(2,length(minimum))=exNR;
            end
end
 openl = ([open1 open2  open3 open4 ]);
 openr=  ([open5  open6 open7 open8]);
 
 