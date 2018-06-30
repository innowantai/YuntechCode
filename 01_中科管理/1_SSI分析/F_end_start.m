function [temp_es reco avefn] = end_start(sort_wn,Nc,span)
len = size(sort_wn,1);
j = 1; p = 1;
temp_es = zeros(1,2);
reco = zeros(1,1);
while j <= (len -Nc + 1)
    e_s = sort_wn(j+Nc-1,3) - sort_wn(j,3);
    reco(j,1) = e_s;
    if e_s <= span
        temp_es(p,1) = j; temp_es(p,2) = e_s;
        p = p + 1;
    end
    j = j + 1;
end

avefn = mean(sort_wn(:,3));