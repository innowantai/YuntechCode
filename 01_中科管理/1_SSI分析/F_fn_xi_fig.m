function F_fn_xi_fig(Finxi0,Finxi1,mark,colo,wnrang,xi_h,filename)
plot(Finxi0(:,3),Finxi0(:,4),'Color',colo,'Marker',mark,'LineStyle','none','Markersize',5);hold on
plot(Finxi1(:,3),Finxi1(:,4),'Color','r','Marker','o','LineStyle','none','Markersize',5);
line([wnrang(1,1) wnrang(1,2)], [xi_h xi_h],'Color','k');
line([wnrang(1,2) wnrang(1,2)], [0 xi_h],'Color','k');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(Finxi0(301:400,3),Finxi0(301:400,4),'Color','g','Marker',mark,'LineStyle','none','Markersize',5);hold on
% plot(Finxi1(151:200,3),Finxi1(151:200,4),'Color','m','Marker','o','LineStyle','none','Markersize',5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axis([wnrang(1,1) wnrang(1,2) 0 xi_h]);
xdid = wnrang(1) : 0.5 : wnrang(2);
ydid = 0 : 1 : xi_h;
set(gca,'Xtick',xdid,'Ytick',ydid);
cell_y='\fontsize{12}\fontname{Times New Roman} Damping Ratio (%)';ylabel(cell_y);
cell_axial='\fontsize{12}\fontname{Times New Roman} Frequency (Hz)';xlabel(cell_axial)
set(gca,'FontSize',12,'FontName','Times New Roman');box off;
title(filename);
set(gcf,'Units','Centimeters','Position',[0 0 13 17]);