clear all;clc;close all;


for  ye2 = 2
     
name = ['F_' num2str(ye2)  ];load(name); name2=['r=' name];evalc(name2);

ll=length(r);     
;ll=length(r); 
; r=r'; rst=r; oldr=r;
x = 1:ll; ii = fix(log(ll))+10;

stand= 0.5 ;   %%% stop standard
thre = 12;   %%% Ignore standard 

%%%%%% plot Figure control parameter %%%%%%%
openf  =   1   %%%% on or off
stt=4;                       %%%% plot which IMF
Lf=1;                        %%%% first Round   
Rf=26;                       %%%% last Round
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Cratr zeros matrix %%%%%%%%%%%%%%
IMF=zeros(ii,ll);           %%%% IMF variable
stdd=zeros(1000,50);        %%%% Standard deviation of each signal
mstdd=zeros(1000,50);       %%%% Standard deviation of mean envelope
judge2=zeros(1000,50);      %%%% Judge stop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%  EMD part  %%%%%%%%%%%%%%%
i = 0; ss=1000;

while i < ii
    i=i+1;j=0;kkk=0;
   
    while j < ss         
        j=j+1;
           %%%%%%%%%¡@Find extrema point %%%%%%%
           [maxima,minimum] = extremanumber(r,x);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
           %%%%%%%% Open ignore mechanism %%%%%%           
           [maxima minimum] = process_ignore(maxima,minimum,r,i,j,stt,thre);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
           %%%%%% Boundary processing and mean envelope line %%%%%
           [maxima,minimum,openl,openr] = boundcondition(maxima,minimum,x,r); 
           [matchmax  ] = spline(maxima(1,:),maxima(2,:),x);
           [matchmin  ] = spline(minimum(1,:),minimum(2,:),x);
           average = (matchmax+matchmin)/2;
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%            %%%%%%%%%%%%%%%%% PEMD Data save %%%%%%%%%%%%
%            max_n{j,i} = maxima; min_n{j,i} = minimum;           
%            lc1 = length(c1(:,1)); lc2=length(c2(:,1));
%            index1{j,i} = c1(lc1,:);  index2{j,i} = c2(lc2,:);index3{j,i} = r;
%            max_sp{j,i} = matchmax; min_sp{j,i} = matchmin; mean_sp{j,i} = average;
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
            %%%%%%%  Plot figure for each round %%%%%%%%   
           if openf == 1 & i == stt & j >= Lf & j<= Rf ;  plot_each_round_control(x,r,maxima,minimum,matchmax,matchmin,average,i,j,ye2);  end
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
           
           %%%%%%%%%%%%%%% Stopping standard %%%%%%%%%%
           stdd(j,i) = std(r); mstdd(j,i) = std(average);  r = r-average;           
           judge2(j,i) = mstdd(j,i)/stdd(j,i)*100;         
           if judge2(j,i) <= stand, check_round(i) = j; check_open(i) = 0; oldj = j; j = 20001; end        
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    end
   
    Roundn(i,1)=oldj; IMF(i,:)=r; rst=rst-r; r=rst;
        
    %%%%%%%%%% Check extrema point for stop %%%%%%%%%%
    [com_m,com_n]=extremanumber(r,x); compare_stop=length(com_m)+length(com_n);
    if  compare_stop < 8, ii=i; IMF(i+1,:)=r; Check = sum(IMF)-oldr; end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    
end

%%%%%%%%%%% Reset IMF %%%%%%%%%%
iter = 0 ; open=1;
while open==1
   iter=iter+1;test = mean(IMF(iter,:)); 
   if test ==0 , open = 0; end    
end
IMF2 = IMF(1:iter-1,:) ; IMF = IMF2;

save('IMF','IMF')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Save PEMD Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save('IMF','IMF');save('judge2','judge2');save('max_n','max_n');save('min_n','min_n');save('max_sp','max_sp');save('min_sp','min_sp')
% save('mean_sp','mean_sp');save('index1','index1');save('index2','index2');save('index3','index3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Roundn
end
