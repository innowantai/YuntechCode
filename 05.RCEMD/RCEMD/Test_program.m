clear all;clc;close all

ye2 = 2; name = ['F_' num2str(ye2)]; load(name);
name2 = ['v=' name]; evalc(name2);


stand = 0.5;
thre = 12;
[IMF] = RCEMD(v,stand,thre);



ss = min(size(IMF));
x=1:length(IMF);
for i=1:ss
%     figure(i)
   subplot(8,1,i)
   plot(x,IMF(i,:));    
end









