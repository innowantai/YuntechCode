function [ judge ii AA] =  A_UsingJudgeModeNumber_sub(coe,ii,type)
 
compare1 = abs(coe{1,1}) ;
compare2 = abs(coe{1,2}) ;
compare3 = abs(coe{1,3}) ;
test1 = sign(coe{1,1}) ; %%%%%%%% 1 = >0 , -1 = <0
test2 = sign(coe{1,2});
test3 = sign(coe{1,4}) ;
test4 = sign(coe{1,5}) ;
AA = coe{1,6}; 
BB = AA;
going = 0;
judge = 0;

if type == 'AB'
    if (ii == 1 & test1 == 1 & test2 == 1 & test3 == 1 & test4 == 1) | (ii == 1 & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1)
       going = 1  ; 
       if test1 == 1 & test2 == 1
           ii = 1;
       else
           ii = 2;
       end
    elseif (ii == 2 & test1 == 1 & test2 == 1 & test3 == 1 & test4 == 1) | (ii == 2 & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1)   
       going = 1  ; 
       if test1 == 1 & test2 == 1
           ii = 1;
       else
           ii = 2;
       end           
    elseif ii == 3 & test1 == 1 & test2 == 1 & test3 == -1 & test4 == -1  
       going = 1  ;           
    elseif (ii == 4  & test1 == 1 & test2 == 1 & test3 == 1 & test4 == 1) | (ii == 4  & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1) 
       going = 1 ;   
       if test1 == 1 & test2 == 1
           ii = 4;
       else
           ii = 5;
       end          
    elseif (ii == 5  & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1) | (ii == 5  & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1)
       going = 1 ;  
       if test1 == 1 & test2 == 1
           ii = 4;
       else
           ii = 5;
       end          
    end



    if going == 0 |  compare3 < 12  
         judge = 0; compare1=0;compare2=0;AA=[];BB=0; ii = [];
    else
        judge = 1;
    end
end







%%%%%%%%%%%%% For CD part %%%%%%%%%%%%%
if type == 'CD'
    %%%%%%%%%%%%%%% 

if (ii == 1 & test1 == 1 & test2 == 1 & test3 == 1 & test4 == 1) | (ii == 1 & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1)
       going = 1  ; 
       if test1 == -1 & test2 == -1
           ii = 1;
       else
           ii = 2;
       end
elseif (ii == 2 & test1 == 1 & test2 == 1 & test3 == 1 & test4 == 1) | (ii == 2 & test1 == -1 & test2 == -1 & test3 == 1 & test4 == 1)   
       going = 1  ; 
       if test1 == 1 & test2 == 1
           ii = 2;
       else
           ii = 1;
       end           
elseif ii == 3 & test1 == 1 & test2 == 1 & test3 == -1 & test4 == -1  
       going = 1  ;           
elseif (ii == 4 & test3 == 1 & test4 == 1)   
       going = 1 ;    
           ii = 4;
    end



    if going == 0 |  compare3 < 12  
         judge = 0; compare1=0;compare2=0;AA=[];BB=0; ii = [];
    else
        judge = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  