function [maxima,minimum,exML,exMR,exNL,exNR]=boundcondition3(maxima1,minimum1,x,r)
maxima=maxima1;
minimum=minimum1;
Lmax=length(maxima);
Lmin=length(minimum);

if length(maxima)>=4
exML=interp1(maxima(1,2:3),maxima(2,2:3),x(1,1),'linear','extrap');
exMR=interp1(maxima(1,(Lmax-2:Lmax-1))  ,maxima(2,(Lmax-2:Lmax-1)),  x(1,length(x)),'linear','extrap');

if maxima(2,1)<exML
    maxima(2,1)=exML;
end

if maxima(2,length(maxima))<exMR
    maxima(2,length(maxima))=exMR;    
end
end

if length(minimum)>=4
    exNL=interp1(minimum(1,2:3),minimum(2,2:3),x(1,1),'linear','extrap');
    exNR=interp1(minimum(1,(Lmin-2:Lmin-1)),minimum(2,(Lmin-2:Lmin-1)),x(1,length(x)),'linear','extrap');

if minimum(2,1)>exNL
    minimum(2,1)=exNL;
end

if minimum(2,length(minimum))>exNR
    minimum(2,length(minimum))=exNR;
end
end

