function [result] = A_UsingClassEachModeInformation(data,index,type)


if type == 'AB';    fn_L = [0.65 0.85 1.8 1.9];    fn_U = [0.8 1.05 2.05 2.1]; modename = [1 3 4 5];else    fn_L = [0.95 1.35 2.4 ];    fn_U = [1.3 1.5 2.8  ]; modename = [1 3 4];end


ak = zeros(5,1);
for jj = 1 : length(fn_L);   
        po{jj} = find(index >= fn_L(jj) & index <= fn_U(jj)) ;     %%%% Ori position
        coeindex = data(:,po{jj}); 
        if isempty(coeindex) ~= 1
            for kk = 1 : size(coeindex,2)
                process = coeindex(:,kk);
                coe1 = corrcoef(process{1,1},process{3,1});
                coe2 = corrcoef(process{2,1},process{4,1}) ;
                if type == 'AB'
                    coe4 = corrcoef(process{1,1},process{2,1});
                    coe5 = corrcoef(process{3,1},process{4,1});
                else
                    index1 = process{1,1};   index2 = process{2,1};
                    index3 = process{3,1};   index4 =  process{4,1};
                    coe4 = corrcoef(index1,index2(:,end-2:end));
                    coe5 = corrcoef(index3,index4(:,end-2:end));                    
                end
                coe = {coe1(1,2) coe2(1,2) process{5,1} coe4(1,2) coe5(1,2) process{8,1}};
                [ judge modeNumber AA] =  A_UsingJudgeModeNumber_sub(coe,modename(jj),type);
                oriPo = po{jj};
                ak(modeNumber,1) =  ak(modeNumber,1)  + 1; 
                modePo(modeNumber,ak(modeNumber,1)) = oriPo(kk); 
                judgeA(modeNumber,ak(modeNumber,1)) = AA;
                
%                 modeData(jj,kk) = modeNumber;
%                 shindex(jj,kk) = AA;  
%                 figure();              A_TestPlotModeShape(process,type)
            end
%             dataPo(jj,1:kk) = po{jj};
        end        
    end;
    
    
    result = zeros(size(modePo,1),1);
    for i = 1 : size(modePo,1)
        compare = find(modePo(i,:));
        if isempty(compare) == 0
            indexVa = judgeA(i,:);
            [va, po] = min(indexVa(find(indexVa~=0)));
           result(i,1) = modePo(i,po);      
        end
    end
    
    
    
    
    
    