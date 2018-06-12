function varargout = Practica1415(varargin)
% PRACTICA1415 MATLAB code for Practica1415.fig
%      PRACTICA1415, by itself, creates a new PRACTICA1415 or raises the existing
%      singleton*.
%
%      H = PRACTICA1415 returns the handle to a new PRACTICA1415 or the handle to
%      the existing singleton*.
%
%      PRACTICA1415('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRACTICA1415.M with the given input arguments.
%
%      PRACTICA1415('Property','Value',...) creates a new PRACTICA1415 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Practica1415_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Practica1415_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Practica1415

% Last Modified by GUIDE v2.5 27-Dec-2014 19:27:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Practica1415_OpeningFcn, ...
                   'gui_OutputFcn',  @Practica1415_OutputFcn, ...
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


% --- Executes just before Practica1415 is made visible.
function Practica1415_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Practica1415 (see VARARGIN)

% Choose default command line output for Practica1415
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Practica1415 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Practica1415_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Hito 1 - El concepto de flujo
% --- Executes on button press in cilindrotierra.
function cilindrotierra_Callback(hObject, eventdata, handles)
% hObject    handle to cilindrotierra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cilindro_tierra] = vaciado(1,10,9.80655,0.015)


% --- Executes on button press in conotierra.
function conotierra_Callback(hObject, eventdata, handles)
% hObject    handle to conotierra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cono_tierra] = vaciado(2,10,9.80655,0.015)


% --- Executes on button press in esferatierra.
function esferatierra_Callback(hObject, eventdata, handles)
% hObject    handle to esferatierra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[esfera_tierra] = vaciado(3,10,9.80655,0.015)


% --- Executes on button press in cilindroluna.
function cilindroluna_Callback(hObject, eventdata, handles)
% hObject    handle to cilindroluna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cilindro_luna] = vaciado(1,10,1.622,0.038)


% --- Executes on button press in conoluna.
function conoluna_Callback(hObject, eventdata, handles)
% hObject    handle to conoluna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[cono_luna] = vaciado(2,10,1.622,0.038)


% --- Executes on button press in esferaluna.
function esferaluna_Callback(hObject, eventdata, handles)
% hObject    handle to esferaluna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[esfera_luna] = vaciado(3,10,1.622,0.038)


%% Hito 2 - Modelización de flujo de tráfico en un arco. CTM
% --- Executes on button press in normal.
function normal_Callback(hObject, eventdata, handles)
% hObject    handle to normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
traficodearco(1);


% --- Executes on button press in semaforo.
function semaforo_Callback(hObject, eventdata, handles)
% hObject    handle to semaforo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
traficodearco(2);


% --- Executes on button press in ambos.
function ambos_Callback(hObject, eventdata, handles)
% hObject    handle to ambos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
traficodearco(1);
traficodearco(2);
subplot(2,1,1);
legend('Sin Semáforo','Con Semáforo');
subplot(2,1,2);
legend('Sin Semáforo','Con Semáforo');

%% Hito 3 - Modelización de flujo en una red
% --- Executes on button press in grafica1.
function grafica1_Callback(hObject, eventdata, handles)
% hObject    handle to grafica1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flujoenred(1);

% --- Executes on button press in grafica2.
function grafica2_Callback(hObject, eventdata, handles)
% hObject    handle to grafica2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flujoenred(2);

% --- Executes on button press in ambas.
function ambas_Callback(hObject, eventdata, handles)
% hObject    handle to ambas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flujoenred(3);


%% Botones GUI adicionales & App Banner
% --- Executes on button press in manual.
function manual_Callback(hObject, eventdata, handles)
% hObject    handle to manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('manual.pdf');


% --- Executes on button press in info.
function info_Callback(hObject, eventdata, handles)
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = sprintf(['      Escuela Superior de Informática - Universidad de Castilla-La Mancha\n',...
    '            Práctica MATLAB 2014/2015 - Cálculo y Métodos Numéricos\n\n',...
    '                         Implemented with MATLAB GUI Environment\n',...
    '                               Copyright 2015 - Juan Perea Campos\n']);
msgbox(str,'Información de la Aplicación','help');


% --- Executes on button press in reiniciar.
function reiniciar_Callback(hObject, eventdata, handles)
% hObject    handle to reiniciar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
clear all
close all
Practica1415;


% --- Executes on button press in salir.
function salir_Callback(hObject, eventdata, handles)
% hObject    handle to salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Practica1415);


% --- Executes during object creation, after setting all properties.
function banner_CreateFcn(hObject, eventdata, handles)
% hObject    handle to banner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
imshow('banner.jpg');
% Hint: place code in OpeningFcn to populate banner
