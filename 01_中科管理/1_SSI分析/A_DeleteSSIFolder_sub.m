function A_DeleteSSIFolder_sub(pathname,dataFolder,detName1)



for ii = 1 : length(dataFolder)
    index = dataFolder{ii,1};
    detPath = [pathname '\' index]; 
    try
      rmdir([detPath '\' detName1],'s') ;
    catch
    end
end
