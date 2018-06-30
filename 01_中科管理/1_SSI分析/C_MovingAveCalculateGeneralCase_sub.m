function m_move = C_MovingAveCalculateGeneralCase_sub(index,m_stand)


[ll ss] = size(index); change = 0;
if ss > ll ; index = index'; [ll ss] = size(index); change = 1; end  
kk = 0; m_move = zeros(ll,ss); temp = zeros(1,ss);
for i = (m_stand/2) : ll-m_stand/2
    mean_position = (1+kk):(m_stand+kk); 
    m_move(i,:) = mean(index(mean_position,:));    
    kk = kk + 1;
end
head_part = find(m_move(1:ll/2,1)==0);   
for j = 1 : ss;     m_move(head_part,j) = m_move(max(head_part)+1,j);end;
tail_part = find(m_move(1:end,1)==0);   
for j = 1 : ss;      m_move(tail_part,j) = m_move(min(tail_part)-1,j);end;
if change ==1 ; m_move = m_move'; end

