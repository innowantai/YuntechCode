function [ para,saveName ] = SSI_ParaLoadingDataUsing()

fid = fopen('SSI_Parameter.txt','r'); 
open = 1; kk = 0;k1 = 0; k2 = 0;
for i = 1 : 11
    index = fgetl(fid);
   if i <= 9
      k1 = k1 + 1; 
      para(k1) = str2num(index);
   else
       k2 = k2 + 1;
       saveName{k2} = index;
   end
end
fclose(fid);