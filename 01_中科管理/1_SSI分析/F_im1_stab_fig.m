function Fin2 = F_im1_stab_fig(F1,Fin,dt,wnrang,mark,colo,FYLimi,filename,plotOpen)
% check the arguments
if (nargin < 4); wnrang = [0 (1/dt)/2]; end
if (nargin < 5); mark = 'x'; end
if (nargin < 6); colo = 'r'; end
if (nargin < 7); FYLimi = 0; end


iint = Fin(1,1);
j = 0; index = find(Fin(3:end,1) ~= 0);  in = max(index);
ind = in; nn = in;
for k = 1 : size(Fin,2) - 1
    Fin2(j+1:in,3) = Fin(3:2+ind,k);
    Fin2(j+1:in,2) = 1:nn;
    Fin2(j+1:in,1) = Fin(1,k)*ones(length(index),1);
    index = find(Fin(3:end,k+1) ~= 0);  ind = max(index);
    j = size(Fin2,1);
    in = ind + j;
end

if plotOpen == 1
    
    [N l] = size(F1);
    if N <l; F1 = F1'; [N l] = size(F1); end
    Tp = (N - 1) * dt;
    w = 0 : (1/Tp) : 1/dt; % unit: Hz
    g = max(Fin(1,end-1)); % max time Lag (i)
    F2 = zeros(N,l);
    for k = 1 : l
        F2(:,k) = g.*(F1(:,k)./max(F1(:,k)));
    end
    F3 = F2(:); F3 = sort(F3);
    set(gca,'YAxisLocation','right','YScale','linear','FontSize',12,'FontName','Times New Roman',...
        'YTickLabel',{},'ticklength',[0 0],'XAxisLocation','top','Xticklabel',{});
    box off;
    for k = 1 : l
        line(w,F2(:,k),'Color',[0.8 0.8 0.8]);hold all
    end
    % cell_yaxial='\fontsize{12}\fontname{Times New Roman} Fourier Amplitude (cm)';
    %ylabel(cell_yaxial)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xdid = wnrang(1) : 1 : wnrang(2);
    ax1 = gca;
    set(ax1,'Xcolor','k','Ycolor','k','XLim',[wnrang(1) wnrang(2)],...
        'YLim',[FYLimi F3(end)+10],'YTickLabel',{},'XTick',xdid);
    ax2 = axes('Position',get(ax1,'Position'),...
             'XAxisLocation','bottom',...
             'YAxisLocation','left',...
             'FontSize',12,...
             'FontName','Times New Roman',...
             'Color','none',...
             'Xcolor','k','Ycolor','k');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    ydid = iint : 20 : g;
    line(Fin2(:,3),Fin2(:,1),'Color',colo...
        ,'Marker',mark,'LineStyle','none','Markersize',5,'Parent',ax2);
    line([wnrang(1) wnrang(2)],[g+1 g+1],'LineStyle','-','Color','k','Parent',ax2);
    line([wnrang(2) wnrang(2)],[0 g+1],'LineStyle','-','Color','k','Parent',ax2);
    set(ax2,'XLim',[wnrang(1) wnrang(2)],'YLim',[iint-1, g+1],'Xtick',xdid,'Ytick',ydid);
    cell_axial='\fontsize{12}\fontname{Times New Roman} Frequency (Hz)';
    xlabel(cell_axial);
    cell_yax='\fontsize{12}\fontname{Times New Roman} Time Lag \it\fontsize{12}\fontname{Times New Roman} i';
    ylabel(cell_yax);
    title(filename);
    % set(H2,'PlotBoxAspectRatioMode','manual');
    % set(H2,'PlotBoxAspectRatio',[1 0.7 1]);
    % set(gcf, 'PaperPositionMode', 'manual');
    % set(gcf, 'PaperUnits', 'centimeters');
    % set(gcf, 'PaperPosition', [0 0 14.33 5.74]);
fix = 12.5 ; fiy = 7.5*2
set(gcf, 'PaperPosition', [0 0 fix fiy]);

    set(gcf,'Units','Centimeters','Position',[0 0 13 17]);

end