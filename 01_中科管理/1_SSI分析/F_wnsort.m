function [Fins Finc] = F_wnsort(Fin,wnrang,filename,plotOpen)

[~, IX] = sort(Fin(:,3));
Fins = Fin(IX,:);
ind = find(Fins(:,3) > wnrang(1,1) & Fins(:,3) <= wnrang(1,2));
Finc = Fins(ind(1):ind(end),:);

if plotOpen == 1
    num = 1 : length(Finc);
    plot(Finc(:,3),num,'color','k','marker','x','Linestyle','none','Markersize',4);
    line([wnrang(1,1) wnrang(1,2)], [num(end)+10 num(end)+10],'Color','k');
    line([wnrang(1,2) wnrang(1,2)], [0 num(end)+10],'Color','k');
    axis([wnrang(1) wnrang(end) 0 num(end)+10]);
    cell_axial='\fontsize{12}\fontname{Times New Roman} Frequency (Hz)';xlabel(cell_axial);
    cell_yax='\fontsize{12}\fontname{Times New Roman} Rank';ylabel(cell_yax);
    set(gca,'FontSize',12,'FontName','Times New Roman'); box off
    title(filename)
    % cell_head = ['\bf\fontsize{12}\fontname{Times New Roman} Total Number ='...
    %     sprintf('%8.0f',length(Finc))];
    % title(cell_head);
end