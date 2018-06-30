function [maxima minimum] = process_ignore(maxima,minimum,r,ii,jj,stt,thre)
 
%%%%% Figure control %%%%%%
openf = 0 ;
fs = 1  ;
fe = 5  ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% Sort interval between adjecent extrema %%%%%%
safe=1; openn=0; lr=length(r); x=1:lr;
lm = length(maxima); ln = length(minimum);
tem = maxima(1,2:lm-1); ten = minimum(1,2:ln-1);
te = sort([tem ten]); ll = length(te);
delta = zeros(1,ll-1);
for i=1:ll-1
   delta(i) = te(i+1) - te(i) ; 
end
olddelta = sort(delta) ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mind=min(delta); medd=median(delta); maxd=max(delta);
if medd >= thre , openn =1; end
while openn == 1   
    compare = min(delta);           %%% min inderval     
    if compare <= thre & safe ==1   %%% If the minima interval small then threshold , Do ignore progream        
        %%%%%%%%%%%%%%% Ignore program %%%%%%%%%%%%%%%%%
        [maxima  minimum safe]=process_ignore_sub(maxima,minimum,r,compare,safe,lm,ln,delta);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        lm = length(maxima); ln = length(minimum);
        tem = maxima(1,2:lm-1); ten = minimum(1,2:ln-1);
        te = sort([tem ten]);  ll = length(te);
        delta = zeros(1,ll-1);
        for i=1:ll-1
            delta(i) = te(i+1) - te(i) ; 
        end
    else
        openn=0;
    end        
        
end

%%%%%%%%%%%%%%%%% bound process %%%%%%%%%%%%%%%%%%%%%%%%
lm=length(maxima);ln=length(minimum); l=length(r);
if maxima(1,lm)~=l , index=[l;123]; maxima(:,lm+1)=index;end
if minimum(1,ln)~=l, index=[l;123]; minimum(:,ln+1)=index;end 
maxima(2,1)=r(1); minimum(2,1)=r(1);
maxima(2,length(maxima))=r(lr); minimum(2,length(minimum))=r(lr);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   





%%%%%%%%%%%%% Plot figure of interval sort %%%%%%%%%%%%%%%%%%
if openf  == 1 & ii==stt & jj>=fs & jj <= fe
   ll2=length(olddelta);
   xx = 1:ll2;
   p = plot(olddelta,xx,'r.');hold on
   na1=['med =' num2str(medd)]; na2=['max=' num2str(maxd)]; na3=['¬Û°£=' num2str(medd/maxd) ];
   plot([thre thre],[0 ll2],'r')
   poy=length(xx); pox=length(delta); 
   text([(medd+maxd)/2],poy/3,na3);
   text([(medd+maxd)/2],poy/3+poy/10,na2);
   text([(medd+maxd)/2],poy/3+poy/5,na1);
   axis([0,inf ,0,inf]);
   xlabel('Time between Adjacent Extrema','fontsize',7,'fontname','Times New Roman')
   ylabel('Rank','fontsize',7,'fontname','Times New Roman') 
   set(get(p,'Parent'),'FontSize',6,'fontname','Times New Roman')
   set(gcf, 'PaperUnits', 'centimeters');
   set(gcf, 'PaperPosition', [0 0 11 8]);
   title(['Round ' num2str(jj) ' (' num2str(thre)  ')'],'fontsize',9,'fontname','Times New Roman')
   name1=['a_threshold_' num2str(ii) '_' num2str(jj)];
   print('-f1', '-djpeg', '-r300', name1);
   close all;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end



