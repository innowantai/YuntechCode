function [xip1 xip3 nx avexi] = F_xi_fig(Finp,inxi,Nx,iint,imax)
xip = Finp(:,1:2);
Nc = size(Finp,1);
for k = 1 : Nc
    pos = Finp(k,1) == inxi(:,1);
    xip(k,4) = inxi(pos,Finp(k,2) + 1);
    xip(k,3) = Finp(k,3);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ind,~] = find(xip(:,3) >0 & xip(:,3)< 70.7);
% Nc = size(ind,1);
% xip1 = xip(ind,:);
xip1 = xip;
[~,pos] = sort(xip1(:,4));
xip2 = xip1(pos,:);
g = 1;
es = zeros(1,1);
while g <= Nx
    es(g,1) = xip2(g+Nx-1,4) - xip2(g,4);
    g = g + 1;
end
[~,IX] = min(es);
xip3 = xip2(IX:IX+Nx-1,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nx = size(xip3,1); avexi = mean(xip3(:,4));
% stdxi = std(xip3(:,4)); cv = (stdxi / avexi)* 100;
% plot(xip(:,4),xip(:,1),'Color','k','Marker','x','LineStyle','none','Markersize',3); hold on
% plot(xip3(:,4),xip3(:,1),'Color','r','Marker','o','LineStyle','none','Markersize',3);
% axis([0 5 iint-2 imax+2]);
% set(gca,'FontSize',12,'FontName','Times New Roman');
% title(['xi (%) = ',sprintf('%4.3f',avexi),...
%     ' ,S.D. (%) = ',sprintf('%4.4f',stdxi),' ,C.V. (%) = ',sprintf('%4.4f',cv)]);
% cell_axial='\fontsize{12}\fontname{Times New Roman} Damping Ratio (%)';xlabel(cell_axial);
% cell_yax='\fontsize{12}\fontname{Times New Roman} Time Lag \it\fontsize{12}\fontname{Times New Roman} i';
% ylabel(cell_yax);