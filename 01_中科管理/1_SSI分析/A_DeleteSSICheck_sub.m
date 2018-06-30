function A_DeleteSSICheck_sub(pathname,dataFolder,detName1)



for ii = 1 : length(dataFolder)
    index = dataFolder{ii,1};
    detPath = [pathname '\' index]; 
    delete([detPath '\' detName1]) ;
end
