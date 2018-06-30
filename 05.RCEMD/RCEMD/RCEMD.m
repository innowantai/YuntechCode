function [IMF] = RCEMD(r,stand,thre)

ll=length(r); r=r'; rst=r; oldr=r; x = 1:ll; ii = fix(log(ll))+10;
%%% stand : stop standard
%%% thre : Ignore standard 

%%%%%% plot Figure control parameter %%%%%%%
openf  =  0 ;              %%%% on or off
stt=1;                       %%%% plot which IMF
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
i = 0;
while i < ii
    i=i+1;j=0; sub_open=1;   
    while sub_open == 1         
        j=j+1;
           %%%%%%%%%¡@Find extrema point %%%%%%%
           [maxima,minimum] = extremanumber(r,x);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
           %%%%%%%% Open ignore mechanism %%%%%%           
           [maxima minimum] = process_ignore(maxima,minimum,r,i,j,stt,thre);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
           %%%%%% Boundary processing and mean envelope line %%%%%
           [maxima,minimum] = boundcondition(maxima,minimum,x,r); 
           [matchmax ] = spline(maxima(1,:),maxima(2,:),x);
           [matchmin ] = spline(minimum(1,:),minimum(2,:),x);
           average = (matchmax+matchmin)/2;
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
         
           %%%%%%%  Plot figure for each round %%%%%%%%   
           if openf == 1 & i == stt & j >= Lf & j<= Rf ;  plot_each_round_control(x,r,maxima,minimum,matchmax,matchmin,average,i,j);  end
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
           
           %%%%%%%%%%%%%%% Stopping standard %%%%%%%%%%
           stdd(j,i) = std(r); mstdd(j,i) = std(average);  r = r-average;           
           judge2(j,i) = mstdd(j,i)/stdd(j,i)*100;         
           if judge2(j,i) <= stand, check_round(i) = j; oldj = j; sub_open = 0 ; end        
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    end
   
    Roundn(i,1)=oldj; IMF(i,:)=r; rst=rst-r; r=rst;
        
    %%%%%%%%%% Check extrema point to stop %%%%%%%%%%
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
 
%%%%%%%%%%%%%%%%%%%%%%%%%%