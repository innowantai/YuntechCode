function A_TestPlotModeShape(process,type)



dist_A = [22.65 36.05 48.65 65.45]; dist_B = [27.65 36.05 48.65 65.45];  dist_C = [27.65 36.05 48.65]; dist_D = [12.65 22.65 36.05 48.65];
if type == 'AB';    tickname = {'3F' '4F' '6F' '9F' '13F'}; dist_1 = dist_A; dist_2 = dist_B; ;     yname = sort([dist_A dist_B]); else;    tickname = {'1F' '3F' '4F' '6F' '9F'}; dist_1 = dist_C; dist_2 = dist_D;   ; yname = sort([dist_1 dist_2]);end;
for i = 1 : length(yname) ;    index = yname(i);    for j = i + 1 : length(yname);        if yname(j) == index;           yname(j) = 0;        end;     end; end; 
% titlename1 = dataFolder; try;    titlename1(findstr(titlename1,'(1)'):findstr(titlename1,'(1)')+2) = '';    catch;    end;
ytick = yname(find(yname));  

FS = 14;
result = process;
allmode = size(result,2);
for target = 1 : allmode 
    Cx = result{1,target}; Dx = result{2,target}; Cy = result{3,target}; Dy = result{4,target};
    titlename2 = ['Num= ' num2str(result{5,target}) ',fn (Hz)=' num2str(result{6,target},'%0.3f') 'Xi(%)=' num2str(result{7,target},'%0.2f')];
    
    subplot(1,2,1)
    for jj = 1 : size(Dx,1);   a3 = plot(Cx(jj,:),dist_1,'-xb'); hold on;     plot(Dx(jj,:),dist_2,'-xr');  end ; grid on
    set(gca,'ytick',ytick,'yticklabel',tickname,'xtick',[-12:0.4:12]);  
    xlabel(['x-Direction Mode Shape Ratio'],'fontsize',FS)
    ylabel(['Location'],'fontsize',FS)
    set(get(a3,'Parent'),'FontSize',FS-2,'fontname','Times New Roman')   ; 
    axis([-1.2 1.2 floor(min([dist_1 dist_2]))-10 ceil(max([dist_1 dist_2]))+3])
    
    subplot(1,2,2)
    for jj = 1 : size(Cy,1);   a3 = plot(Cy(jj,:),dist_1,'-xb'); hold on;     plot(Dy(jj,:),dist_2,'-xr');  end ; grid on
    set(gca,'ytick',ytick,'yticklabel',tickname,'xtick',[-12:0.4:12]);   
    xlabel(['y-Direction Mode Shape Ratio'],'fontsize',FS)
    ylabel(['Location'],'fontsize',FS)
    set(get(a3,'Parent'),'FontSize',FS-2,'fontname','Times New Roman')   ;
    title(titlename2,'fontsize',FS)
    axis([-1.2 1.2 floor(min([dist_1 dist_2]))-10 ceil(max([dist_1 dist_2]))+3]) 
end