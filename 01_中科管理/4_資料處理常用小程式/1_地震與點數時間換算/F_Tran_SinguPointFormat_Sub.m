function [Sing ] = F_Tran_SinguPointFormat_Sub(EqSinguPoint)


for jj = 1 : length(EqSinguPoint)
   index = EqSinguPoint{jj};
   if index(end-1:end) == '15'
      index(end-1:end) = '00';
      target = 2;
   elseif index(end-1:end) == '45'
      index(end-1:end) = '30';    
      target = 2  ; 
   else
      target = 1;       
   end
   
   Sing{jj,1} = index;
   Sing{jj,2} = target;
    
end