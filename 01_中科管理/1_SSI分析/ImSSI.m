function [dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang ] = ImSSI_AB16_2(yy,dt,n3,iint,imax,work,filename,lblpercent,nowi,totalii,wnrang,praBar)

[l ny]=size(yy);if (ny<l);yy=yy';[l ny]=size(yy); end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
[~, ym2, ~, F2, ~] = HWF(yy,dt);
ym2 = yy; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

kj =imax  :-1: iint  ;   ks = length(kj); 
omega = zeros(ks,n3);  damping = zeros(ks,n3);  PHI = zeros(ks*l,n3);
infn = zeros(3,length(kj)-1); ii = 1; 
 
%%%%%%%%%%%% imax %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
j = ny-2*kj(ii)+1;
Ti = B_blh_to_T(ym2,kj(ii),j,l);  
[A C ss] = C_ObMaxrtix_AC(Ti,n3,l,kj(ii));  
[fn xi,modeshape] = D_IDmode(A,C,dt); 
omega(ii,:) = fn;    
damping(ii,:) = xi;
infn(1,ii) = kj(ii); 
infn(2,ii) = n3;
infn(3:3+n3-1,ii) = fn.'; 
PHI2{ii,1} = modeshape;
ii = ii + 1  ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pkk = (imax-iint)*(nowi-1);
di = imax - iint;
for ik = imax-1  :-1: iint      
    [Ti] = A_detAC(ym2,kj(ii),n3,Ti);  
    [A C ss] = C_ObMaxrtix_AC(Ti,n3,l,kj(ii));   
    [fn xi,modeshape] = D_IDmode(A,C,dt); 
    omega(ii,:) = fn;    
    damping(ii,:) = xi;
    infn(1,ii) = kj(ii); 
    infn(2,ii) = n3;
    infn(3:3+n3-1,ii) = fn.'; 
    PHI2{ii,1} = modeshape;
    ii = ii + 1  ;
    pkk = pkk +  1 ;   
    usingtime = toc;
    set(lblpercent,'string',[ num2str(round(pkk / (totalii)*100)) '% (' num2str(usingtime/60,'%0.1f') '╓юда)' ]);
    axes(praBar)
    rectangle('position',[(totalii)/150 0.2 pkk 9], 'FaceColor' ,'g','edgecolor','w'); 
    pause(0.0001)
    
end



%%% flipud
omega = flipud(omega);damping = flipud(damping);PHI2 = flipud(PHI2);
%%% fliplr
infn = fliplr(infn) ;kj = fliplr(kj);
%%% position processinf
PHI = PHI2{1};   [PHI_s1 PHI_s2] = size(PHI);
for i = 2 : max(size(PHI2))
    PHI = [PHI;PHI2{i}];
end
    PHI = [PHI;zeros(PHI_s1,PHI_s2)];
 
infn(1,ii) = kj(end)+1;
inxi = [kj.' damping ]; 
inxi(ii,1) = kj(end)+1;
kj = iint : 1 : imax + 1;
gg = ones(l,1)*kj; 
inPHI = [gg(:) PHI];
mark = 'x'; colo = 'r'; FYLimi = 0;

% figure(1) 
Fin0 = im1_stab_fig(F2,infn,dt,wnrang,mark,colo,FYLimi);
% close all;
%%%% SAVE File %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd([work ,'\',filename]);
save ('infn.txt','infn','-ascii');
save('Fin0.txt','Fin0','-ascii');
save('iint.txt','iint','-ascii');     save('imax.txt','imax','-ascii'); 
save('wnrang.txt','wnrang','-ascii'); save('FYLimi.txt','FYLimi','-ascii'); 
save('dt.txt','dt','-ascii'); 
save('inxi.txt','inxi','-ascii'); 
inPHI_R = real(inPHI);  inPHI_I = imag(inPHI);
save('inPHI_R.txt','inPHI_R','-ascii');  save('inPHI_I.txt','inPHI_I','-ascii'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


