function [group1 group] = F_siftwn(Finc,Nc,span)
len = size(Finc,1); 
j = 1; 
e_s = zeros(1,1);
while j <= (len - Nc + 1)
    e_s(j,1) = Finc(j+Nc-1,3) - Finc(j,3); 
    j = j + 1;
end
ind = find(e_s <= span);
err = e_s(ind,:); 
%%%%%%     find local min    %%%%%%%%%%%%%
m = 2; n = 2;
spmin(1,1) = 1;
spmin(1,2) = err(1);
N = length(err);
while m < N
    if err(m-1) >= err(m) && err(m) <= err(m+1)
        spmin(n,1) = m;
        spmin(n,2) = err(m);
        n = n + 1;
    end
    m = m + 1;
end
pmin = [ind(spmin(:,1)) spmin(:,2)];
p = 1; 
h = 1; ess = zeros(1,2);
while p <= size(pmin,1)
      temp = pmin(p,1) + Nc - 1;
      mi = find(temp >= pmin(:,1), 1, 'last' );
      [~, ii] = min(pmin(p:mi,2));
      jj = ii + p - 1;
      ess(h,:) = pmin(jj,:);
      p = max(mi) + 1;
      h = h + 1;
end
group = [ess(:,1) ess(:,1)+Nc].';
%%%%%%%% 2016/04/05 %%%%%%%%%%%%%%%%%%%%%
C = size(group,2);
t = 1;  t1 = 1;
group_m = group; group1 = zeros(2,1);
while t < C
    if group_m(2,t) >= group_m(1,t+1)
        group1(1,t1) = group_m(1,t);
        group1(2,t1) = group_m(2,t+1);
        t = t + 1; 
    else 
        group1(:,t1) = group_m(:,t); 
    end
     t1 = t1 + 1; t = t + 1;
end
if group1(:,end) - group_m(:,end) ~= zeros(2,1) & size(group_m,2) ~= 1
    group1(:,end+1) = group_m(:,end);
else
    group1 = group_m;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
