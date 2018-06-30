function [Resi , expEq] = F_TransDataToResiAndExceptEQPoint_sub(Data_New,eqPoint,Target,expEq,savePath)

work_ori = cd;

type_ = {'AB' 'CD'}; 
for ii = 1 : 2
    type = type_{ii};   
    target = Target(ii);
    data = Data_New{ii}; STD = data(:,1);  Fn = data(1:end,target);    
    STD(eqPoint) = 0;      Fn(eqPoint) = 0;
    oriSTD = STD; oriFn = Fn;
    %%%%%%% Take off noData Points %%%%%%%%
    non = find(Fn);     Fn = Fn(non); STD = STD(non);
    non = find(STD);    Fn = Fn(non); STD = STD(non);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
     
    
    %%%%%%%% Filter Fn feat STD %%%%%%%% 
    fit_dexp2 = @(x) expEq(ii,1)*exp(expEq(ii,2)*x)+expEq(ii,3); 
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
    %%%%%%%%%%%% Filter and Interp Nodata Point Part %%%%%%%%%%%%%%% 
    STDs = A_ProcessInterpOrExtrapForNoDataPoint_sub(oriSTD);
    Fns = A_ProcessInterpOrExtrapForNoDataPoint_sub(oriFn); 
    reIndex = fit_dexp2(STDs); resi = Fns - reIndex;                 %%%%% Using to Save
    reIndex = fit_dexp2(STD);  resiExp = Fn - reIndex;               %%%%% Using to Statstics
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
    
    Resi{ii,1} = resi; 
end

 