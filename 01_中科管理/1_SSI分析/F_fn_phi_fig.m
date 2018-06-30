function F_fn_phi_fig(Finxi1,alpha,wnrang,num,Nx,filename,modedet)
B = alpha;
B(B == 0) = -1;
alpha = B;
for k = 1 : num
    infx1 = Finxi1((k-1)*Nx+1:k*Nx,:);
    plot(infx1(:,3),alpha(k,:),'color','r','marker','o','LineStyle','none','Markersize',3);hold on
end
line([wnrang(1,1) wnrang(1,2)],[modedet modedet],'lineStyle','--','Color',[0.1 0.7 0.2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% plot(Finxi1(151:200,3),alpha(4,:)*100,'color','m','marker','o','LineStyle','none','Markersize',3);hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
line([wnrang(1,1) wnrang(1,2)],[modedet*1.5 modedet*1.5],'Color','k');
line([wnrang(1,2) wnrang(1,2)],[0 modedet*1.5],'Color','k');
axis([wnrang(1,1) wnrang(1,2) 0 modedet*1.5]);box off
cell_yax='\fontsize{12}\fontname{Times New Roman} Average Distance Index of Mode Shape Vector (%)';ylabel(cell_yax);
cell_axial='\fontsize{12}\fontname{Times New Roman} Frequency (Hz)';xlabel(cell_axial);
set(gca,'FontSize',12,'FontName','Times New Roman');
title(filename)
set(gcf,'Units','Centimeters','Position',[0 0 13 17]);
