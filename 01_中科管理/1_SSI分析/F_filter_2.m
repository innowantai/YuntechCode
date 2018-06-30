function [Finxi0, Finxi1, fnxi_data] = F_filter_2(Nc,Fin3,inxi,iint,imax) 
  
 
C = size(Fin3,1)/ Nc;
Nx = fix(Nc/2); 
fnxi_data = zeros(C,3);
for k = 1 : C
    Finp = Fin3((k-1)*Nc+1:k*Nc,:); 
    [xip1, xip3, nx, avexi] = F_xi_fig(Finp,inxi,Nx,iint,imax); 
    Finxi0((k-1)*Nc+1:k*Nc,:) = xip1;
    Finxi1((k-1)*Nx+1:k*Nx,:) = xip3;
    avefn = mean(xip3(:,end-1));
    fnxi_data(k,:) =[nx avefn avexi];
end 