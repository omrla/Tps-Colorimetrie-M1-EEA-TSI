function varargout = GUI_Dematricage(varargin)
% GUI_DEMATRICAGE M-file for GUI_Dematricage.fig
%      GUI_DEMATRICAGE, by itself, creates a new GUI_DEMATRICAGE or raises the existing
%      singleton*.
%
%      H = GUI_DEMATRICAGE returns the handle to a new GUI_DEMATRICAGE or the handle to
%      the existing singleton*.
%
%      GUI_DEMATRICAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DEMATRICAGE.M with the given input arguments.
%
%      GUI_DEMATRICAGE('Property','Value',...) creates a new GUI_DEMATRICAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Dematricage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Dematricage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Dematricage

% Last Modified by GUIDE v2.5 07-Jan-2011 02:13:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Dematricage_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Dematricage_OutputFcn, ...
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


% --- Executes just before GUI_Dematricage is made visible.
function GUI_Dematricage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Dematricage (see VARARGIN)
%%%--Chargement d'images:
Image1=imread('Ima_phare.tif');
handles.Image1=Image1;

Image2=imread('Maison.tif');
handles.Image2=Image2;

Image3=imread('peppers.png');
handles.Image3=Image3;

handles.current_data=handles.Image1;
Ima_originale(handles.current_data);

% Choose default command line output for GUI_Dematricage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Dematricage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Dematricage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1*

val=get(hObject,'Value');
str=get(hObject,'String');
switch str{val}
    case 'Image1' % --selection de l'image 1
        handles.current_data=handles.Image1;
    case 'Image2'% --selection de l'image 2
        handles.current_data=handles.Image2;
    case 'Image3'% --selection de l'image 3
        handles.current_data=handles.Image3;
end
guidata(hObject,handles);
        
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ima_originale.
function Ima_originale_Callback(hObject, eventdata, handles)
% hObject    handle to Ima_originale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ima_originale(handles.current_data)

% --- Executes on button press in Image_CFA.
function Image_CFA_Callback(hObject, eventdata, handles)
% hObject    handle to Image_CFA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Image_CFA(handles.current_data)



% --- Executes during object creation, after setting all properties.
function Ima_originale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ima_originale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in InterpoBilin.
function InterpoBilin_Callback(hObject, eventdata, handles)
% hObject    handle to InterpoBilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%InterpoBilin (handles.current_data)
global A
A=1;

% --- Executes on button press in IntSsCtCT.
function IntSsCtCT_Callback(hObject, eventdata, handles)
% hObject    handle to IntSsCtCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%IntSsCtCT (handles.current_data)
global A
A=2; 

% --- Executes on button press in IntSsCtPC.
function IntSsCtPC_Callback(hObject, eventdata, handles)
% hObject    handle to IntSsCtPC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%IntSsCtPC (handles.current_data)
global A
A=3;

% --- Executes on button press in Dematricage.
function Dematricage_Callback(hObject, eventdata, handles)
% hObject    handle to Dematricage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A
Dematricage(handles.current_data,A)


% --- Executes on button press in BiliMsq.
function BiliMsq_Callback(hObject, eventdata, handles)
% hObject    handle to BiliMsq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A
A=4;


