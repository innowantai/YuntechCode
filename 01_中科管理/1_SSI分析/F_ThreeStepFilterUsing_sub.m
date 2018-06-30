function [ mode Tot_fnxi max_aveall] = F_ThreeStepFilterUsing_sub(ya,span,filename,modedet,Nc,dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang,plotOpen,folderPath,SSI_Figure)

 
 work_ori = cd;

  
[s l] = size(ya); if l >  s ; ya = ya'; [s l] = size(ya); end
%%%%%%%%%% Auto-sifting process %%%%%%%%%%%%%%%%
 
[Fin3, group, group1] = F_filter_1(ya,Nc,span,filename,wnrang,infn,iint,FYLimi,dt,imax,Fin0) ;  
[Finxi0, Finxi1, fnxi_data] = F_filter_2(Nc,Fin3,inxi,iint,imax)  ; 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C = size(group1,2);   Nx = Nc/2;
alpha = zeros(C,Nx);  Tot_fnxi = zeros(C,2); 
for k = 1 : C 
    Finp = Fin3((k-1)*Nc+1:k*Nc,:);
    xip3 = Finxi1((k-1)*Nx+1:k*Nx,:); 
    [avefnxi, mode3, avesum, nn, avefn,avexi,max_ave,check_ratio] = F_filter_3(xip3,l,Finp,modedet,inPHI_R,inPHI_I) ;        
    mode{k} = mode3;
    alpha(k,:) = avesum;
    Tot_fnxi(k,:) = avefnxi;
    num(k) = nn;  
    max_aveall(k,1) = max_ave;
end              
 Tot_fnxi = Tot_fnxi';
if plotOpen == 1
    [~, ~, ~, F2, ~] = HWF(ya,dt);  
    a1 = figure(1); mark = 'x'; colo = 'k';  
    [~] = F_im1_stab_fig(F2,infn,dt,wnrang,mark,colo,FYLimi,filename,plotOpen);               
    a2 = figure(2); 
    [~, ~] = F_wnsort(Fin0,wnrang,filename,plotOpen);  
    a4 = figure(4); colo = 'b';
    [~] =F_im1_stab_fig1(F2,Fin3,iint,imax,dt,wnrang,mark,colo,FYLimi,filename); 
    a7 = figure(7);  xi_h = 5;  mark = 'x'; colo = 'b';  
    F_fn_xi_fig(Finxi0,Finxi1,mark,colo,wnrang,xi_h,filename);  
    a8 = figure(8); 
    F_fn_phi_fig(Finxi1,alpha,wnrang,C,Nc/2,filename,modedet);

    cd([folderPath '\' SSI_Figure]);
    saveas(figure(1),['0_' filename '_IM_SSI_Stab_Fig.jpeg']);                        
    saveas(figure(2),['1_' filename '_Rank.jpeg']);
    saveas(figure(4),['2_' filename '_Sift1_IM_SSI_Stab_Fig.jpeg']);  
    saveas(figure(7),['3_' filename '_Fn_Xi_Fig.jpeg']);      
    saveas(figure(8),['4_' filename '_Average Distance Index of Mode Shape Vector (%).jpeg']);
    delete(a1); delete(a2); delete(a4); delete(a7); delete(a8);
    cd(work_ori)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 