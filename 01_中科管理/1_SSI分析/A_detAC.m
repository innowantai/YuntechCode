function [Ti]=A_detAC(y,i,n3,Ti)

[l ny]=size(y);if (ny<l);y=y';[l ny]=size(y); end
% % Determine the number of columns in Hankel matrices 
j = ny-2*i+1; 
j0 = ny-2*(i+1)+1;
                                                
[Yp Yf] = B_blkhank(y/sqrt(j-1),i,j);                                                           
tt = Yf*Yp';
Lt=size(Ti,1); 
Ti = Ti(1:(Lt-l),(l+1):end)*(j0-1)/(j-1) + tt; 


