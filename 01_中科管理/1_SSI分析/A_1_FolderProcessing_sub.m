function dataFolder = A_1_FolderProcessing_sub(pathname,SSI_Figure)


if pathname ~= 0
    process = dir([pathname ]);
    alldata = struct2cell(process);
    k = 0;    
    for i = 1 : size(alldata,2);   
        index = findstr(alldata{1,i},'.');   
        if isempty(index) == 1 & strcmp(alldata{1,i},SSI_Figure) ~= 1;     
            k = k + 1;      dataFolder{k,1} =  alldata{1,i};  
        end;
    end;
end;
 