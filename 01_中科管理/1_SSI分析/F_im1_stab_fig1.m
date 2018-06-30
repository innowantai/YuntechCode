function [nn fnave fnsd fncv] = F_im1_stab_fig1(F1,Finp,iint,imax,dt,wnrang,mark,colo,FYLimi,filename)
% check the arguments
if (nargin < 5); wnrang = [0 (1/dt)/2]; end
if (nargin < 6); mark = 'x'; end
if (nargin < 7); colo = 'r'; end
if (nargin < 8); FYLimi = 0; end
[N l] = size(F1);
if N < l; F1 = F1'; [N l] = size(F1); end
Tp = (N - 1) * dt;
w = 0 : (1/Tp) : 1/dt;
g  = imax;
F2 = zeros(N,l);
for k = 1 : l
    F2(:,k) = g.*(F1(:,k)./max(F1(:,k)));
end
F3 = F2(:); F3 = sort(F3);
set(gca,'YAxisLocation','right','YScale','linear','FontSize',12,'FontName','Times New Roman');
for k = 1 : l
   a3 =  line(w,F2(:,k),'Color',[0.8 0.8 0.8]);hold all
end
cell_axial='\fontsize{12}\fontname{Times New Roman} Frequency (Hz)';
% cell_yaxial='\fontsize{12}\fontname{Times New Roman} Fourier Amplitude (cm)';
xlabel(cell_axial);%ylabel(cell_yaxial)
set(gca,'TickLength',[0 0]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%]
xdid = wnrang(1) : 1 : wnrang(2);
ax1 = gca;
set(ax1,'Xcolor','k','Ycolor','k','XLim',[wnrang(1) wnrang(2)],...
    'YLim',[FYLimi F3(end)+10],'YTickLabel',{},'XTick',xdid);
ax2 = axes('Position',get(ax1,'Position'),...
         'XAxisLocation','Bottom',...
         'XTickLabel',{},...
         'XTick',zeros(1,0),...
         'YAxisLocation','left',...
         'FontSize',12,...
         'FontName','Times New Roman',...
         'Color','none',...
         'Xcolor','k','Ycolor','k',...
         'TickLength',[0.015 0.015]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ydid = iint : 20 : g;
fnave = mean(Finp(:,3)); nn = size(Finp,1);
fnsd = std(Finp(:,3)); fncv = (fnsd / fnave) * 100;
line(Finp(:,3),Finp(:,1),'Color',colo...
    ,'Marker',mark,'LineStyle','none','Markersize',5,'Parent',ax2);hold on
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(ax2,'XLim',[wnrang(1) wnrang(2)],'YLim',[iint-1, g+1],'Xtick',xdid,'Ytick',ydid);
line([wnrang(1) wnrang(2)],[g+1 g+1],'LineStyle','-','Color','k','Parent',ax2);
cell_yax='\fontsize{12}\fontname{Times New Roman} Time Lag \it\fontsize{12}\fontname{Times New Roman} i'; ylabel(cell_yax);
line([wnrang(2) wnrang(2)],[0 g+1],'LineStyle','-','Color','k','Parent',ax2);
% title(['Num = ',sprintf('%4.0f',nn),',fn (Hz) = ',sprintf('%4.3f',fnave),...
%     ' ,S.D. (Hz) = ',sprintf('%4.3f',fnsd),' ,C.V. (%) = ',sprintf('%4.3f',fncv)]);

% set(get(a3,'Parent'),'FontSize',8,'fontname','Times New Roman')   ; 
title(filename);
fix = 12.5 ; fiy = 7.5*2
set(gcf, 'PaperPosition', [0 0 fix fiy]);
set(gcf,'Units','Centimeters','Position',[0 0 13 17]);