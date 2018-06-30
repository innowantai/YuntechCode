function plot_each_round_control(x,r,maxima,minimum,matchmax,matchmin,average,i,j)

ye = 9 ;

if ye ==1 | ye ==5
    names = ['Spring '];
elseif ye ==2 | ye ==6
    names = ['Summer '];
elseif ye ==3 | ye ==7  
    names = ['Autumn '];
elseif ye ==4 | ye ==8
    names = ['Winter '];
else 
    names = ['Undefine'];
end

maxima(1,:)=(maxima(1,:)); minimum(1,:)=(minimum(1,:));
lm=length(maxima);ln=length(minimum);

if ye<=4 | ye > 8
    namey=['Temperature Variation (\circC)'];
elseif ye < 8
    namey=['Percentage of Cable Force Variation (%)']
else
    namey = ['Undefine'];
end
    
if j==1
    namey=['{\it b}_{' num2str(i-1) '}' ];
elseif j>10
    namey=['{\it h}_{' num2str(i) '(' num2str(j-1) ')}' ];
else
   namey=['{\it h}_'  num2str(i) '_' num2str(j-1) ];
end

x=x/96; maxima(1,:)=maxima(1,:)/96; minimum(1,:)=minimum(1,:)/96;
p=plot(x,r,'-k','markersize',5,'linewidth',1.3);hold on


%%%%%% Control figure coordinate range %%%%%%%
aa = ceil(abs(max(r))*1.3); 
bb = -floor(abs(min(r))*1.3);
bo=ceil(max(x))
axis([ 0,bo,bb,aa ]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% Control figure size position %%%%%%%%%
set(gca,'outerposition',[-0.07 0 1.16 1])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizemark=2.5 ; %%%%% Control marker size 
size2 = 12; 
size3 = 12;



p1=plot(maxima(1,1:lm),maxima(2,1:lm),'^c','markersize',sizemark);
p2=plot(minimum(1,1:ln),minimum(2,1:ln),'Vg','markerface','g','markersize',sizemark );
p3=plot(x,matchmax,'-.c');p4=plot(x,matchmin,'-.g');
plot(x,average,'-.r');
xlabel('Time (day) ','fontsize',size2 ,'fontname','Times New Roman')
ylabel(namey,'fontsize',size2 ,'fontname','Times New Roman')
set(get(p,'Parent'),'FontSize',size3,'fontname','Times New Roman')
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 5]);
set(gca,'YLim',[-aa aa],'fontsize',size2)
set(gca,'Ytick',[-aa:2:aa],'fontsize',size2)

% title(['²Ä' num2str(j) '¦^¦X'],'fontsize',size2+3,'fontname','Times New Roman')
% title(['\it'   'b_{' num2str(i-1)  '} ' '\rm'],'fontsize',10,'fontname','Times New Roman');

col=[0.1 0.4 1]; col2=[0.1 0.6 0.1];
set(p1,'color',col,'markerface',col,'markersize',sizemark); set(p3,'color',col)
set(p2,'color',col2,'markerface',col2,'markersize',sizemark); set(p4,'color',col2)
set(gca,'Xtick',[0:1:bo],'fontsize',size3)
set(gca,'ticklength',get(gca,'ticklength')/2); 
name1 = ['0_Round_' num2str(j) '_' num2str(i)];
print('-f1', '-djpeg', '-r300', name1);

close all