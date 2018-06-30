function [A C SVDresult] = C_ObMaxrtix_AC(Ti,n3,l,i)

[U, S, ~]=svd(Ti); 
ss = diag(S);
% Determined the order (n3=100);
n = n3*2;
U1 = U(:,1:n);
% Determined Observability Matrix & Controllability Matrix
Oi = U1*diag(sqrt(ss(1:n)));
Oi1 = Oi(l+1:l*i,:);
Oi2 = Oi(1:l*(i-1),:);
% Solve A and C Matrix
C = Oi(1:l,:);
A = pinv(Oi2)*Oi1;

UU = U(:,1:n*2); 
SVDresult = {UU ss};