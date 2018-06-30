function Z_ToPlotFigureForEachCase(x,Inputy,Xlabel,Ylabel,s1,s2,Savename)




orixx = 0.07; oriyy = 0.08; oriww = 0.88;
if s1 == 1
    orihh = 0.88;
else
    orihh = 0.8;
end

fix = 16; fiy = 9; parent_size = 6, Fs = 8;
 


judge = iscell(Inputy);
if judge == 1
   for ii = 1 : length(Inputy)
       test = Inputy{ii};
       yu(ii) = max(test);
       yl(ii) = min(test);
   end
   yu = max(yu); yl = min(yl);
   inputy = Inputy;
else
    [ss1 ss2] = size(Inputy); if ss1 > ss2 ; Inputy = Inputy'; [ss1 ss2] = size(Inputy); end
    for ii = 1 : ss1
       inputy{ii} = Inputy(ii,:); 
    end
    yu = max(max(Inputy')); yl = min(min(Inputy'));
end
  


dy = 1.15;
ww = oriww/s2/1.02; hh = orihh/s1;
xx = orixx; oriyy = oriyy + (s1-1)*hh*dy; kk  = 0;
for ii = 1 : s2
    yy = oriyy;
    for jj = 1 : s1
        kk = kk + 1;
        index = inputy{kk};
        axes('position',[xx yy ww hh])
        a3 = plot(x,index);
        set(get(a3,'Parent'),'FontSize',parent_size,'fontname','Times New Roman') 
        set(gca,'ticklength',get(gca,'ticklength')/5) ;
        axis([0 max(x) yl yu]);
        if ii ~= 1
            set(gca,'yticklabel',{});
        else
            ylabel(Ylabel,'FontSize',Fs)
        end        
        
        if jj ~= s1
            set(gca,'xticklabel',{})            
        else
            xlabel(Xlabel,'FontSize',Fs)            
        end        
        yy = yy - hh*dy; 
    end
    xx = xx + ww*1.1;
end
        

set(gcf, 'PaperPosition', [0 0 fix fiy]);  
print(['-f' num2str(1)], '-djpeg', '-r300', [Savename]);
close all;






