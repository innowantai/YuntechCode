function [maxima,minimum,mm,nn]=extremanumber(r,x)
iterm=0;
itern=0;
ll=length(r);
maxima=zeros(2,ll/2);
minimum=zeros(2,ll/2);
i=2;
mm=0;
nn=0;
i2=0;
compare1=0;
while i<(ll)
    
    Lt=r(1,i)-r(1,i-1);
    Rt=r(1,i)-r(1,i+1); 
    test=Lt*Rt;
    if test>0      
        if Lt > 0 
            mm=mm+1;
            iterm=iterm+1;
            maxima(1,iterm+1)=x(1,i);
            maxima(2,iterm+1)=r(1,i);
        elseif Lt <0 
            nn=nn+1;
            itern=itern+1;
            minimum(1,itern+1)=x(1,i);
            minimum(2,itern+1)=r(1,i);
        end
    end      
   
    if test ==0 & i < ll-2
       open=1;i2=i+1;
       
       while open == 1
           compare1=r(i2)-r(i2+1);
           if compare1 ==0
               i2=i2+1;
           else
               open=0;
           end           
       end
       
       if Lt > 0 & compare1 > 0
            mm=mm+1;
            iterm=iterm+1;
            maxima(1,iterm+1)=x(1,i);
            maxima(2,iterm+1)=r(1,i);
        elseif Lt <0 & compare1 < 0
            nn=nn+1;
            itern=itern+1;
            minimum(1,itern+1)=x(1,i);
            minimum(2,itern+1)=r(1,i);
       end        
        i=i2;      
    end   
    
    i=i+1;
end


open=1; i=1;pom=0;
while open==1
    i=i+1;
    if maxima(1,i)==0
        pom=i-1;
        open=0;
    end    
end
maxima2=maxima(1:2,1:pom);maxima=0;
maxima=maxima2;

open=1; i=1;pon=0;
while open==1
    i=i+1;
    if minimum(1,i)==0
        pon=i-1;
        open=0;
    end    
end
minimum2=minimum(1:2,1:pon);minimum=0;
minimum=minimum2;



Lmax=length(maxima);
Lmin=length(minimum);
maxima(1,Lmax+1)=x(1,length(x));
minimum(1,Lmin+1)=x(1,length(x));

maxima(1,1)=1;
maxima(2,1)=r(1,1);

minimum(1,1)=1;
minimum(2,1)=r(1,1);

maxima(2,length(maxima))=r(1,length(r));
minimum(2,length(minimum))=r(1,length(r));