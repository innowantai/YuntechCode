function varargout = SSI(varargin)
% SSI MATLAB code for SSI.fig
%      SSI, by itself, creates a new SSI or raises the existing
%      singleton*.
%
%      H = SSI returns the handle to a new SSI or the handle to
%      the existing singleton*.
%
%      SSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSI.M with the given input arguments.
%
%      SSI('Property','Value',...) creates a new SSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SSI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SSI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SSI

% Last Modified by GUIDE v2.5 26-May-2017 23:46:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSI_OpeningFcn, ...
                   'gui_OutputFcn',  @SSI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SSI is made visible.
function SSI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SSI (see VARARGIN)
clc
% Choose default command line output for SSI
handles.output = hObject;

% Update handles structure
axes(handles.Figure1)
set(handles.lblana,'BackgroundColor',[0 1 0 ]);
set(handles.btnState,'String','等待中','fontname','標楷體','fontsize',16);  
set(handles.lblMake,'fontname','標楷體','foregroundcolor',[0.4 0.4 0.4]);  
rectangle('position',[0 0 10 10], 'FaceColor' ,'w','edgecolor','k');
set(handles.lblPercent,'string',['0%']);axis([0 10 0 10]);
set(handles.Figure1,'xticklabel',{},'Yticklabel',{}) ; 
uistack(handles.FigureLogo,'bottom')
axes(handles.FigureLogo)
I=imread('Yuntech_logo.jpg'); Logo = imagesc(I); 
set(handles.FigureLogo,'ticklength',get(handles.FigureLogo,'ticklength')*0);
set(handles.FigureLogo,'xticklabel',{},'yticklabel',{},'xcolor','w','ycolor','w')
box off
colormap gray


guidata(hObject, handles);
 
 
% UIWAIT makes SSI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SSI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
 


% --- Executes on button press in btnFile.
function btnFile_Callback(hObject, eventdata, handles)
% hObject    handle to btnFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir();
load('para'); SSI_Figure = para{12}
if pathname ~= 0
    process = dir([pathname ]);
    alldata = struct2cell(process);
    k = 0;    
    for i = 1 : size(alldata,2);   
        index = findstr(alldata{1,i},'.');   
        if isempty(index) == 1 & strcmp(alldata{1,i},SSI_Figure) ~= 1;     
            k = k + 1;      foldername{k,1} =  alldata{1,i};  
        end;
    end;
    handles.dataFolder = foldername;
    handles.path = pathname;
    guidata(hObject,handles) ;
    set(handles.txtPath,'string',handles.path);
    state{1,1} = ['總共 ' num2str(length(handles.dataFolder)) '組資料'];
    handles.state = state;
    set(handles.lblStat,'string',handles.state,'foregroundcolor','r');
    guidata(hObject,handles);
end
 

% --- Executes on button press in btnAna.
function btnAna_Callback(hObject, eventdata, handles)
% hObject    handle to btnAna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%% Error text setting  %%%%%%%%%%
datename = datestr(now); datename(findstr(datename,':')) = '-'; Error_name = ['Error Report ' datename '.txt'];
handles.ErrorName = Error_name; fid = fopen(Error_name,'w'); fprintf(fid,'%s ',[''] ) ;  fclose(fid); guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
work_ori = cd;
folderPath = handles.path;
dataFolder = handles.dataFolder;
load('para'); dt = 1/para{1}; timeLength = para{2}; iint = para{3}; imax = para{4}; n3 = para{5}; modedet = para{6}; span = para{7}; Nc = para{8}; plotOpen = para{9}; SSI_result = para{11}; SSI_Figure = para{12};
wnrang = [0 5];
iiup = length(dataFolder);  
PbarMax = iiup*(imax-iint)*2;
axes(handles.Figure1); praBar = handles.Figure1;
rectangle('position',[0 0 PbarMax 10], 'FaceColor' ,'w','edgecolor','k');
set(handles.lblPercent,'string',['0%']);axis([0 PbarMax 0 10]);
rectangle('position',[0 0 PbarMax 10], 'FaceColor' ,'w','edgecolor','k') ;
error_iter = 0; tic;
%%%%%% This part is using to setting sensor name for differ type building %%%%%%%%%%%%%%%%%%%%
type = para{10};
Ax = [13 17 21 25];Ay = [14 18 22 26];Bx = [11 19 23 29];By = [12 20 24 30];Cx = [43 49 51];Cy = [44 50 42];Dx = [37 45 47 54];Dy = [38 46 48 55];
if type == 'AB'; sensor = [Ax Ay Bx By] ;elseif type == 'CD'; sensor = [Dx Dy Cx Cy];   end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
probar_ii = 0;
for ii = 1 :iiup 
    state = handles.state;    state{2,1} = ['現在正在分析第' num2str(ii) '組資料'];     
    set(handles.lblStat,'string',state,'foregroundcolor','r'); 
    set(handles.btnState,'BackgroundColor',[1 0 0],'String','分析中','fontname','標楷體','fontsize',16);     pause(0.3) ; 
    path1 = [folderPath '\' dataFolder{ii}];
    file =struct2cell( dir([path1 '\*.mat']) );      file = file(1,:);   
    if plotOpen == 1 ;mkdir(folderPath,SSI_Figure); end ;  cd(path1); 
    error_open = 0;
    if isempty(file) == 0   ;                                               %%%% If PathFolder not Exist Data,don't to Anaylysis 
        try
           datename = dataFolder{ii};
           SSI_resultName = datename(1:16);
           SSI_resultName(findstr(SSI_resultName,'-')) = '_';  SSI_resultName(findstr(SSI_resultName,' ')) = '_';
           year = datename(1:4);       month = datename(6:7);       day = datename(9:10);       hour = datename(12:13);       mm = datename(15:16);
           if mm == '00';            minname= {'00' '15'};       elseif mm == '30';           minname = {'30' '45'};      end;
           try
                %%%%%%%%%%%%%%%% Loading Data %%%%%%%%%%%%%%% 
                load('Squ_data_all');
                yy = Squ_data_all(sensor,:);
                yy = yy(:,1:2:end); 
                cd(work_ori); 
                m_move = C_MovingAveCalculateGeneralCase_sub(yy,30/dt); 
                yy = yy - m_move;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
                trdata = 0;
                for rr = 1 : 2
                    probar_ii = probar_ii + 1;
                    SSI_resultN = [type '_' SSI_result '_' minname{rr}];
                    mkdir(path1,SSI_resultN); 
                    index = yy(:,1+trdata : 90000+trdata);                 trdata = trdata + 90000;
                    lblpercent = handles.lblPercent;
                    [dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang ] = ImSSI(index,dt,n3,iint,imax,path1,SSI_resultN,lblpercent,probar_ii,PbarMax,wnrang,praBar); cd(work_ori);               
                     try
                        [ mode fnxi] = F_ThreeStepFilterUsing_sub(index,span,[dataFolder{ii} '-' minname{rr}],modedet,Nc,dt,Fin0,FYLimi,iint,imax,infn,inPHI_I,inPHI_R,inxi,wnrang,plotOpen,folderPath,SSI_Figure)
                        
                        if type == 'AB'
                            for i = 1 : size(fnxi,2);            
                                indexMode = mode{1,i};                  
                                result{1,i} = indexMode(:,1:4);      
                                result{2,i} = indexMode(:,5:8);           
                                result{3,i} = indexMode(:,9:12);         
                                result{4,i} = indexMode(:,13:16);            
                                result{5,i} = size(indexMode,1);
                                result{6,i} = fnxi(1,i);            
                                result{7,i} = fnxi(2,i);                               
                            end;                            
                        else
                            for i = 1 : size(fnxi,2);  
                                indexMode = mode{1,i};  
                                result{1,i} = indexMode(:,9:11); 
                                result{2,i} = indexMode(:,1:4);   
                                result{3,i} = indexMode(:,12:14);  
                                result{4,i} = indexMode(:,5:8);    
                                result{5,i} = size(indexMode,1); 
                                result{6,i} = fnxi(1,i);
                                result{7,i} = fnxi(2,i);  
                            end;
                        end
                        
                        name = ['alldata_' type '_' SSI_resultName '_' minname{rr}];    name2 = [name ' =  result']; evalc(name2);
                        cd([folderPath '\' SSI_Figure]);  save(name,name) ;   cd(work_ori);       
                     catch
                        %%%%%%%%%% Data Parameter Error Record %%%%%%%%%%%%%%%%%%%%
                        error_open = 1; textFile = [num2str(error_iter) '.資料夾 ' dataFolder{ii} ' 篩分參數設定有誤(可能是Delta f太小),無法完成篩分 ']; 
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                     end
                 end
            catch
                %%%%%%%%%% DataLength Error Record %%%%%%%%%%%%%%%%%%%%
                error_open = 1; textFile = [num2str(error_iter) '.資料夾 ' dataFolder{ii} '內訊號長度有問題 ']; 
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        catch
            %%%%%%%%%% Data Parameter Error Record %%%%%%%%%%%%%%%%%%%%
            error_open = 1; textFile = [num2str(error_iter) '.資料夾 ' dataFolder{ii} '名稱有誤,可能不是中科管理局之data資料夾(XXXX-XX-XX XX-XX-XX) '];            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
        end
    else         
        %%%%%%%%%%%% Folder Error Record %%%%%%%%%%%%%%%%%
        error_open = 1; textFile = [num2str(error_iter) '.資料夾 ' dataFolder{ii} '內沒有訊號檔案 '];  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        probar_ii = probar_ii + 2;
    end
    
    if error_open == 1;   cd(work_ori);  error_iter = error_iter + 1;  fid = fopen(handles.ErrorName,'a');  fprintf(fid,'%s \n',textFile );  fclose(fid);  end
     
end
if error_iter == 0;    obj=[work_ori '\'  handles.ErrorName];      delete(obj); end
set(handles.btnState,'BackgroundColor',[0 1 0],'String','等待中'); pause(0.3)
state{3,1} = ['分析完成']; set(handles.lblStat,'string',state,'foregroundcolor','r'); 
 



% --- Executes on button press in btnPara.
function btnPara_Callback(hObject, eventdata, handles)
% hObject    handle to btnPara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SSI_ParaSetting_



function txtPath_Callback(hObject, eventdata, handles)
% hObject    handle to txtPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPath as text
%        str2double(get(hObject,'String')) returns contents of txtPath as a double


% --- Executes during object creation, after setting all properties.
function txtPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 


 


% --- Executes on button press in btnState.
function btnState_Callback(hObject, eventdata, handles)
% hObject    handle to btnState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
