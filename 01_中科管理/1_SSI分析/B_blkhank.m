 function [Yp Yf] = B_blkhank(y,i,j)

% Make a (block)-row vector out of y
[l,nd] = size(y);
if nd < l;y = y';[l,nd] = size(y);end

% Check dimensions
if i < 0;error('blkHank: i should be positive');end
if j < 0;error('blkHank: j should be positive');end
if j > nd-i+1;error('blkHank: j too big');end

% Make a block-Hankel matrix
Yp=zeros(l*i,2); Yf=zeros(l*i,2); n = min(size(y)); 
for k=1:i
  Yp((k-1)*n+1:k*n,:) = [y(1:n,k) y(1:n,k+j-1)];
  Yf((k-1)*n+1:k*n,:) = [y(1:n,k+i) y(1:n,k+j-1+i)];
end
