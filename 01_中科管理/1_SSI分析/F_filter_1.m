function [Fin3, group, group1] = F_filter_1(ya,Nc,span,filename,wnrang,infn,iint,FYLimi,dt,imax,Fin0) 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
y1 = ya; 
[~, ~, ~, F2, ~] = HWF(ya,dt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
mark = 'x'; colo = 'k'; %%% wnrang = [0 10];
Fin0 = F_im1_stab_fig(F2,infn,dt,wnrang,mark,colo,FYLimi,filename,0);        
[~, Finc] = F_wnsort(Fin0,wnrang,filename,0);      
[group1, group] = F_siftwn(Finc,Nc,span);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C = size(group1,2);
gi = 0;  js = 1;
for kk = 1 : C
    gp = group1(2,kk) - group1(1,kk) + 1;
    Fin2(gi+1:gp+gi,:) = Finc(group1(1,kk):group1(2,kk),:);
    gi = size(Fin2,1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sort_wn = Finc(group1(1,kk):group1(2,kk),:);
    [temp_es,~] = F_end_start(sort_wn,Nc,span);
    [~, loc] = min(temp_es(:,2));
    temp_Fn = sort_wn(temp_es(loc):temp_es(loc)+Nc-1,:);
    Fin3((js-1)*Nc+1:js*Nc,:) = temp_Fn;
    js = js + 1;
end               