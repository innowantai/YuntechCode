function C_PlotResultFigure_ABandCD_Case2_sub(year,month,type,Data,numberOfDay,pathname)
work_ori = cd;

wind = Data(:,1); temp = Data(:,2);
if type == 'AB';
   STD = Data(:,3);   Fn = Data(:,5:9);   Xi = Data(:,10:14);      number = 5;
   Yname1 = {'Wind Speed (m/s)' 'Temperature (^oC)' 'RMS Acceleration (gal)' };
   Yname2 = {'B1-1 Frequenzy (Hz)' 'B1-1 Damping (%)' 'B1-2 Frequenzy (Hz)' 'B1-2 Damping (%)' 'T1 Frequenzy (Hz)' 'T1 Damping (%)' 'B2-1 Frequenzy (Hz)' 'B2-1 Damping (%)' 'B2-1 Frequenzy (Hz)' 'B2-1 Damping (%)'};
    
   xi = 0.07; yi = 0.916; wi = 0.84 ; hi = 0.080; k = 0;
else;
   STD = Data(:,4);   Fn = Data(:,15:18);   Xi = Data(:,19:end);        number = 4;
   Yname1 = {'Wind Speed (m/s)' 'Temperature (^oC)' 'RMS Acceleration (gal)' };
   Yname2 = {'B1-1 Frequenzy (Hz)' 'B1-1 Damping (%)' 'B1-2 Frequenzy (Hz)' 'B1-2 Damping (%)' 'T1 Frequenzy (Hz)' 'T1 Damping (%)' 'B2 Frequenzy (Hz)' 'B2 Damping (%)' };
    
   xi = 0.07; yi = 0.916; wi = 0.84 ; hi = 0.080; k = 0;
end;
Yname = [Yname1 Yname2];
AllData = {wind temp STD Fn Xi};
time = 1:length(wind); time = time / numberOfDay; 

FS = 8;  MS = 2; para = 12;
color = {[0.56 0.17 0.93] [1 0.8 0.5] [0 1 0] [0 0 1] [1 0 0] [0 0 1] [1 0 0] [0 0 1] [1 0 0] [0 0 1] [1 0 0] [0 0 1] [1 0 0]};
for i = [ 1 3] 
    axes('Position',[xi yi-k*hi wi hi],'FontSize',FS);   k = k + 1;
    index = AllData{i};    
    for jj = 1 : max(time)          plot([jj-0.5 jj-0.5],[-100 100],':','color',[0.5 0.5 0.5]) ; hold on     ;          plot([jj jj],[-100 100],'-','color',[0 0 0]) ; hold on  ;  end    
    
    non = find(index);
    a3 = plot(time(non),index(non),'o','markerfacecolor',color{i},'markeredgecolor',color{i},'MarkerSize',MS);
    if i <= 2
        interval = 4;
        yl = floor(min(index));    yu = ceil(max(index));    dy = rem(yu-yl,interval);    
        if dy == 0
            dy = (yu - yl) / interval;
            ytick = [yl yl+dy*1 yl+dy*2  yl+dy*3  yu]; 
        else 
            yu = yu + interval - dy; 
            dy = (yu - yl) / interval;
            ytick = [yl yl+dy*1 yl+dy*2  yl+dy*3  yu];
        end
    else
        interval = 4;
        yl = round(min(index)*0.9,2);    yu = round(max(index),2);    dy = rem(yu-yl,interval);           
        dy = (yu - yl) / interval;
        ytick = [yl yl+dy*1 yl+dy*2  yl+dy*3  yu];
        ytick = str2num(num2str(ytick','%0.2f'));
    end
    
    set(gca,'xticklabel',{},'ticklength',get(gca,'ticklength')/5,'ytick',ytick,'xtick',0:max(time));
    ylabel(Yname{i},'FontName','Times New Roman','FontSize',FS);
    axis([0 max(time) yl yu]);
    
    if i == 3 ;       set(gca,'YAxisLocation','right');    end    
    para = para - 1;
end

index1 =  AllData{4}; index2 =  AllData{5};
colorFn = [0 0 1]; colorXi = [1 0 0]; kk = 0;
for ii = 1 : number
    Fn = index1(:,ii);     Xi = index2(:,ii);
    out = find(Xi >= 10); Fn(out) = 0;
    non = find(Fn); 
    index = Fn(non);      
    axes('Position',[xi yi-k*hi wi hi],'FontSize',FS);   k = k + 1;
    for jj = 1 : max(time)          plot([jj-0.5 jj-0.5],[-100 100],':','color',[0.5 0.5 0.5]) ; hold on    ;          plot([jj jj],[-100 100],'-','color',[0 0 0]) ; hold on  ;    end
    a3 = plot(time(non),index,'o','markerfacecolor',colorFn,'markeredgecolor',colorFn,'MarkerSize',MS);
    interval = 4;
    yl = round(min(index)*0.99,2);    yu = round(max(index)*1.005,2);    dy = rem(yu-yl,interval);       
    dy = (yu - yl) / interval;  
    ytick = [yl yl+dy*1 yl+dy*2  yl+dy*3  yu];
    ytick = str2num(num2str(ytick','%0.3f'));
    set(gca,'xticklabel',{},'ticklength',get(gca,'ticklength')/5,'ytick',ytick,'xtick',0:max(time)); 
    
    ytick = [yl yl+dy*1 yl+dy*2  yl+dy*3  yu];
    ytick = str2num(num2str(ytick','%0.2f'));
    set(gca,'yticklabel',mat2cell(num2str(ytick),[5])); 
    ylabel(Yname{4+kk},'FontName','Times New Roman','FontSize',FS);
    axis([0 max(time) yl yu]);
    if rem(ii,2) == 0 ; set(gca,'YAxisLocation','right'); end
    
    kk = kk + 2;
    
end


kk = 0; ii2 = ii;
for ii = 1 : number
    Xi = index2(:,ii);
    out = find(Xi >= 10);
    Xi(out) = 0;
    non = find(Xi); 
    index = Xi(non);  
    axes('Position',[xi yi-k*hi wi hi],'FontSize',FS);   k = k + 1;
    for jj = 1 : max(time)          plot([jj-0.5 jj-0.5],[-100 100],':','color',[0.5 0.5 0.5]) ; hold on     ;          plot([jj jj],[-100 100],'-','color',[0 0 0]) ; hold on  ;    end
    a3 = plot(time(non),index,'o','markerfacecolor',colorXi,'markeredgecolor',colorXi,'MarkerSize',MS);    
    interval = 4;
    yl = 0;    yu = round(max(index)*1.005,2);    dy = rem(yu-yl,interval);       
    dy = (yu - yl) / interval; dy = round(dy,2);
    ytick = [yl yl+dy*1 yl+dy*2  yl+dy*3  yu];
    ytick = str2num(num2str(ytick','%0.2f'));
    set(gca,'yticklabel',mat2cell(num2str(ytick),[5])); 
    ylabel(Yname{5+kk},'FontName','Times New Roman','FontSize',FS); kk = kk + 2; 
    axis([0 max(time) yl yu]);   
    if rem(ii+ii2,2) == 0 ; set(gca,'YAxisLocation','right'); end 
    
    if ii == number         
        TickName = datestr([0 : max(time)]+1,'dd');
        set(gca,'ticklength',get(gca,'ticklength')/5,'ytick',ytick,'xtick',0:max(time)-1);
        set(gca,'xticklabel',TickName);
        xlabel('Time (day)','FontName','Times New Roman','FontSize',FS);
    else
        set(gca,'xticklabel',{},'ticklength',get(gca,'ticklength')/5,'ytick',ytick,'xtick',0:max(time));
    end           
end
 
set(gcf,'Units','Centimeters','Position',[40 -7.5 18 26]);
set(gcf, 'PaperPosition', [0 0 19 28]);

cd(pathname)
print('-f1', '-djpeg', '-r300', ['Last_result_' num2str(year) '_' num2str(month) '_' type  '.jpeg']); 
close all;
cd(work_ori);