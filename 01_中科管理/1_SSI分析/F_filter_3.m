function [avefnxi, mode3, avesum,  nn, avefn,avexi,max_ave,check_ratio] = F_filter_3(xip3,l,Finp,modedet,inPHI_R,inPHI_I) 
 
% load inPHI_R.txt;    load inPHI_I.txt;    
i = sqrt(-1); 
inPHI = inPHI_R + i.*inPHI_I;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inphi = xip3(:,1:2)'; 
for k = 1 : size(xip3,1)
    pos = xip3(k,1) == inPHI(:,1);
    inphi(3:3+l-1,k) = inPHI(pos,xip3(k,2)+1);
end
[~,n1] = max(abs(inphi(3:end,:)));
tx = tabulate(n1);
[~,n1] = max(tx(:,3));

Nc = size(inphi,2);
gg = 1 : l;
phi2 = zeros(l,Nc);
re = zeros(l,Nc); im = zeros(l,Nc);
ratio = zeros(Nc,l-1); index = zeros(Nc,l);  amp = zeros(l,Nc);
for k = 1 : Nc
    cc = gg';
    phi2(:,k) = inphi(3:end,k)./inphi(2+n1,k);
    cc(n1,1) = 0; pos = find(cc~=0);
    re(:,k) = real(phi2(:,k));   im(:,k) = imag(phi2(:,k));
    ratio(k,:) = abs(re(pos,k) ./ im(pos,k));
    amp(:,k) = sqrt(re(:,k).^2 + im(:,k).^2);
    for pp = 1 : l
        if re(pp,k) < 0
            amp(pp,k) = -1 * amp(pp,k);
        else
            amp(pp,k) = amp(pp,k);
        end
    end
    ind = find(ratio(k,:) < 3, 1);
    if isempty(ind) == 1
        index(k,1) = 1;
    else
        index(k,1) = 0;
    end
end
phi4 = amp;
nn = size(phi4,2);
in = inphi(1:2,:);
phi5 = zeros(size(phi4));
for k = 1 : nn
    phi5(:,k) = phi4(:,k)./sqrt(sum(phi4(:,k).^2));
end
phi6  = phi5.';
Nc1 = size(phi6,1);
A = zeros(Nc1,Nc1);
for k = 1 :Nc1 -1
    for j = k + 1 : Nc1
        A(j,k) = sqrt(sum((phi6(k,:) - phi6(j,:)).^2)/l);
    end
    A(k,:) = A(:,k);
end
avesum = (sum(A) /(Nc1-1))*100;
[max_ave, max_pos] = max(avesum);
avesum_i = avesum; i = 1; 
dpos = zeros(1,1);
while max_ave > modedet  % Re-do
    dpos(1,i) = max_pos;
    phi5(:,max_pos) = 0;
    phi6 = phi5.';   Nc1 = nn; Nc2 = nn - i;
    i = i + 1;
    A = zeros(Nc1,Nc1);
    for k = 1 : Nc1 -1
        for j = k + 1 : Nc1
            A(j,k) = sqrt(sum((phi6(k,:) - phi6(j,:)).^2)/l);
        end
        A(k,:) = A(:,k);
    end
    A(:,dpos) = 0;  A(dpos,:) = 0;
    avesum = (sum(A) / (Nc2-1))*100;
    phi5 = phi6.';
    [max_ave, max_pos] = max(avesum);
    avesum_i(i,:) = avesum;
end
if dpos == 0
    del_pos = zeros(1,nn);
else
    del_pos = zeros(1,nn);
    del_pos(1,dpos) = 1; 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
res_pos = find(del_pos == 0);   in1 = in(:,res_pos);
mode2 = phi5(:,res_pos);  mode2 = mode2.';

check_ratio = phi2(:,res_pos);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mode3 = mode2;
nn = size(mode3,1);
for kk = 1 : nn
    mode3(kk,:) = mode2(kk,:)./mode2(kk,n1);
end
 

inphi1 = [in1.' mode3];
wn = zeros(nn,1); xi = zeros(nn,1);
for k = 1 : nn
    posf = inphi1(k,1) == Finp(:,1) & inphi1(k,2) == Finp(:,2);
    posx = inphi1(k,1) == xip3(:,1) & inphi1(k,2) == xip3(:,2);
    wn(k,1) = Finp(posf,3);
    xi(k,1) = xip3(posx,4);
end
avefn = mean(wn); avexi = mean(xi);   avefnxi = [avefn avexi];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
