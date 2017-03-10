function varargout = AHWR(varargin)
% AHWR MATLAB code for AHWR.fig
%      AHWR, by itself, creates a new AHWR or raises the existing
%      singleton*.
%
%      H = AHWR returns the handle to a new AHWR or the handle to
%      the existing singleton*.
%
%      AHWR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AHWR.M with the given input arguments.
%
%      AHWR('Property','Value',...) creates a new AHWR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AHWR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AHWR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AHWR

% Last Modified by GUIDE v2.5 28-Dec-2016 23:17:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AHWR_OpeningFcn, ...
                   'gui_OutputFcn',  @AHWR_OutputFcn, ...
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


% --- Executes just before AHWR is made visible.
function AHWR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AHWR (see VARARGIN)

% Choose default command line output for AHWR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AHWR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AHWR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.lines_menu,'reset');
cla(handles.axes3,'reset');
cla(handles.words_menu,'reset');
file_name = uigetfile('E:\4th year\gp\functions\Tests','Select_image');
handles.scanedImage = imread (file_name);
guidata(hObject, handles);
axes(handles.axes1);
imshow(handles.scanedImage);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Lines nLines] = PreProcessAndSegmentLines(handles.scanedImage);
handles.seg_lines=Lines;
set(handles.lines_menu,'String',1:nLines);
guidata(hObject, handles);

% --- Executes on selection change in lines_menu.
function lines_menu_Callback(hObject, eventdata, handles)
% hObject    handle to lines_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lines_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lines_menu
%str = get(hObject, 'String');
val = get(hObject, 'Value');
handles.line_index = val;
guidata(hObject, handles);
axes(handles.axes2);
imshow(imcomplement(handles.seg_lines{handles.line_index}));


% --- Executes during object creation, after setting all properties.
function lines_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lines_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ Words nWords ] = SegmentWords( handles.seg_lines{handles.line_index},20);
handles.seg_words=Words;
set(handles.words_menu,'String',1:nWords);
guidata(hObject, handles);



% --- Executes on selection change in words_menu.
function words_menu_Callback(hObject, eventdata, handles)
% hObject    handle to words_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns words_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from words_menu
val = get(hObject, 'Value');
handles.word_index = val;
guidata(hObject, handles);
axes(handles.axes3);
imshow(imcomplement(handles.seg_words{handles.word_index}));


% --- Executes during object creation, after setting all properties.
function words_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to words_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
