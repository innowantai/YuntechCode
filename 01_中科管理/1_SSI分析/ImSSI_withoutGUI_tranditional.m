function [dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang] = ImSSI_withoutGUI_tranditional(yy,dt,n3,iint,imax,work,filename,wnrang)

[l ny]=size(yy);if (ny<l);yy=yy';[l ny]=size(yy); end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
[~, ym2, ~, F2, ~] = HWF(yy,dt);
ym2 = yy; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

kj =imax  :-1: iint   ;   ks = length(kj); 
omega = zeros(ks,n3);  damping = zeros(ks,n3);  PHI = zeros(ks*l,n3);
infn = zeros(3,length(kj)-1); ii = 1; 
 
%%%%%%%%%%%% imax %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for ii = 1 : 81

j = ny-2*kj(ii)+1; 
Y = B_blkhank_old(ym2,kj(ii)*2,j);   
i = kj(ii);
Yp = Y(1:l*i,:);
Yf = Y(l*i+1:end,:);
test = Y(1:l,:)
tic
Ti = Yf*Yp';
 toc
 
 tic
 test1 = Y(1:l,:);
 test2 = Y(1:l,:)';
 tt = test1*test2;
 toc
% Compute the Singular value Decomposition 
 
[U, S, ~]=svd(Ti);


end

t4 = toc

 

