function allmode = EEMD(Y,Nstd,ran)
Ystd = std(Y);
Y = Y' / Ystd;
xsize = length(Y);
dd = 1:1:xsize;
[NE Np] = size(ran);
TNM = fix(log2(xsize));  %取對數，決定IMF的個數
TNM1 = TNM + 1;
allmode = zeros(xsize,TNM1);
mode = allmode;
% tic
%part3 Do EEMD  -----EEMD loop start
for iii=1:1:NE,   %EEMD loop -NE times EMD sum together
%     ttt=iii
    %part4 --Add noise to original data,we have X1
        temp=ran(iii,:)*Nstd;
        X1=Y+temp;
    %part4 --assign original data in the first column  
%     mode(:,1) = Y;
    %part5--give initial 0 to xorigin and xend
    xorigin = X1;
    xend = xorigin;
    
    %part6--start to find an IMF-----IMF loop start
    conter = 1;
for nmode=1:TNM
        xstart=xend; %last loop value assign to new iteration loop 
                       %xstart -loop start data
        iter=1;      %loop index initial value
 
        %part7--sift 10 times to get IMF---sift loop  start 
        while iter<=100
            %x為資料x座標
            
            [spmax,spmin]=A_extremanumber(xstart,dd);  %call function extrema 
            [maxima,minimum] = B_boundcondition(spmax,spmin,dd,xstart); 
            %the usage of  spline ,please see part11.  
            upper = spline(maxima(1,:),maxima(2,:),dd); %upper spline bound of this sift 
            lower = spline(minimum(1,:),minimum(2,:),dd); %lower spline bound of this sift 
            mean_ul = (upper+lower)/2;%spline mean of upper and lower  
            xstart = xstart-mean_ul;%extract spline mean from Xstart
            iter = iter+1;
        end
        %part7--sift 10 times to get IMF---sift loop  end      
        
        %part8--subtract IMF from data ,then let the residual xend to start to find next IMF 
         xend = xend-xstart;
   
        
        %part9--after sift 100 times,that xstart is this time IMF 
        
        mode(:,conter)=xstart;
        
        conter=conter+1;
    
end
    %part6--start to find an IMF-----IMF loop end

    %part 10--after gotten  all(TNM) IMFs ,the residual xend is over all trend
    %                        put them in the last column 
    % 放入Residue
 
     mode(:,conter)=xend;
 
    %after part 10 ,original +TNM-IMF+overall trend  ---those are all in mode    
     allmode=allmode+mode;

end    
%part3 Do EEMD  -----EEMD loop end
% toc
%part10--devide EEMD summation by NE,std be multiply back to data
allmode=allmode/NE * Ystd;

%part11--the syntax of the matlab function spline
%yy= spline(x,y,xx); this means
%x and y are matrixs of n1 points ,use n1 set (x,y) to form the cubic spline
%xx and yy are matrixs of n2 points,we want know the spline value yy(y-axis) in the xx (x-axis)position
%after the spline is formed by n1 points ,find coordinate value on the spline for [xx,yy] --n2 position. 

