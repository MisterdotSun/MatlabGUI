function varargout = Group3GUI(varargin)
% GROUP3GUI MATLAB code for Group3GUI.fig
%      GROUP3GUI, by itself, creates a new GROUP3GUI or raises the existing
%      singleton*.
%
%      H = GROUP3GUI returns the handle to a new GROUP3GUI or the handle to
%      the existing singleton*.
%
%      GROUP3GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUP3GUI.M with the given input arguments.
%
%      GROUP3GUI('Property','Value',...) creates a new GROUP3GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Group3GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Group3GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Group3GUI

% Last Modified by GUIDE v2.5 22-May-2022 16:13:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Group3GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Group3GUI_OutputFcn, ...
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


% --- Executes just before Group3GUI is made visible.
function Group3GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Group3GUI (see VARARGIN)

% Choose default command line output for Group3GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Group3GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Group3GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ReadImage.
function ReadImage_Callback(hObject, eventdata, handles)
% hObject    handle to ReadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global newpath;
oldpath=cd;
if isempty(newpath) || ~exist('newpath')
    newpath=cd;
end
cd(newpath);

[filename, pathname] = uigetfile( ...
   {'*.bmp;*.jpg;*.png;*.jpeg;*.tif', 'Image Files (*.bmp, *.jpg, *.png,*.jpeg, *.tif)'; '*.*', 'All Files (*.*)'}, '请�?择需要打�?��图像');

fpath=[pathname filename] 
if filename~=0
    newpath=pathname;
end
axes(handles.axes1)
I=imread(fpath);
imshow(I)
setappdata(handles.axes1, 'Ima', I)
setappdata(handles.axes2, 'Ima', I)


% --- Executes on button press in GammaTranform.
function GammaTranform_Callback(hObject, eventdata, handles)
% hObject    handle to GammaTranform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I2=getappdata(handles.axes2, 'Ima');
Gamma=getappdata(handles.axes2, 'num');
I2=imadjust(I2,[],[],Gamma);
axes(handles.axes2);
imshow(I2)

% --- Executes on button press in GetImageHist.
function GetImageHist_Callback(hObject, eventdata, handles)
% hObject    handle to GetImageHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I2=getappdata(handles.axes2, 'Ima');
Gamma=getappdata(handles.axes2, 'num');
axes(handles.axes2);
if length(size(I2))>2
    I2=rgb2gray(I2);
end
imhist(I2,Gamma)

% --- Executes on button press in LoadTemplate.
function LoadTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to LoadTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global newpath;
oldpath=cd;
if isempty(newpath) || ~exist('newpath')
    newpath=cd;
end
cd(newpath);

[filename, pathname] = uigetfile( ...
   {'*.bmp;*.jpg;*.png;*.jpeg;*.tif', 'Image Files (*.bmp, *.jpg, *.png,*.jpeg, *.tif)'; '*.*', 'All Files (*.*)'}, '请�?择需要打�?��图像');

fpath=[pathname filename] 
if filename~=0
    newpath=pathname;
end
axes(handles.axes2);
I=imread(fpath);
imshow(I)
setappdata(handles.axes2, 'Ima', I)
setappdata(handles.axes2,'filename',filename);

% --- Executes on button press in PhtotoAlbum.
function PhtotoAlbum_Callback(hObject, eventdata, handles)
% hObject    handle to PhtotoAlbum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ima=getappdata(handles.axes1,'Ima');
ImaTemp=getappdata(handles.axes2,'Ima');
filename=getappdata(handles.axes2,'filename');

axes(handles.axes1);

while 1
    [~,~,BoundBox]=getbox;
    
    Ima2=imcrop(Ima,BoundBox);
    
    rectangle('Position',BoundBox,'LineWidth',1,'EdgeColor','r','LineStyle','--');
    pause(1)
    
    switch filename
        case{'poster1.jpg'}
            
        case{'poster2.jpg'}
            Ima3=imresize(Ima2,[304 213]);
                
                ImaTemp(52:355,213:425,:)=Ima3;
            case{'baitanzheng.jpg'}
                Ima3=imresize(Ima2,[164 123]);
                
                ImaTemp(245:408,155:277,:)=Ima3;
                
        otherwise
            disp('�ⲻ��Ԥ�����õ�ģ��')
    end

    
    axes(handles.axes3);
  imshow(ImaTemp)
end 


% --- Executes on button press in MedFilter.
function MedFilter_Callback(hObject, eventdata, handles)
% hObject    handle to MedFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(handles.axes2, 'Ima');
       S= str2double(inputdlg('ѡ�����3-5-7'));
       if length(size(I))>2
        I2(:,:,1)=medfilt2(I(:,:,1),[S S]);
        I2(:,:,2)=medfilt2(I(:,:,2),[S S]);
        I2(:,:,3)=medfilt2(I(:,:,3),[S S]);
       else 
       I2=medfilt2(I,[S S]);
       end
       axes(handles.axes3); 
       imshow(I2)

% --- Executes on button press in FourierTranform.
function FourierTranform_Callback(hObject, eventdata, handles)
% hObject    handle to FourierTranform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ima=getappdata(handles.axes1,'Ima');
if ndims(Ima)==3
   Ima=rgb2gray(Ima);
end
I=fft2(double(Ima));
A=log(1+abs(I))
axes(handles.axes2); 
imshow(A,[8 10]);
B=fftshift(I);
C=log(1+abs(B));
axes(handles.axes3); 
imshow(C,[8 10]);
impixelinfo

% --- Executes on button press in MeanFilter.
function MeanFilter_Callback(hObject, eventdata, handles)
% hObject    handle to MeanFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I =  getappdata(handles.axes2, 'Ima');
%I =rgb2gray(I);
I2=imfilter(I,fspecial('average',5));
axes(handles.axes3);
imshow(I2)

% --- Executes on button press in ImageIntensification.
function ImageIntensification_Callback(hObject, eventdata, handles)
% hObject    handle to ImageIntensification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ima=getappdata(handles.axes1,'Ima');
Ima1=getappdata(handles.axes2,'Ima');
R=Ima(:,:,1);
G=Ima(:,:,2);
H=Ima(:,:,3);
A=Ima1(:,:,1);
B=Ima1(:,:,2);
C=Ima1(:,:,3);
D=imhist(A);
E=imhist(B);
F=imhist(C);
Rout=histeq(R,D);
Gout=histeq(G,E);
Bout=histeq(H,F);
J(:,:,1)=Rout;
J(:,:,2)=Gout;
J(:,:,3)=Bout;
axes(handles.axes3);
imshow(J);

% --- Executes on button press in ImageCompression.
function ImageCompression_Callback(hObject, eventdata, handles)
% hObject    handle to ImageCompression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I4 = getappdata(handles.axes1,'Ima');
I4 = rgb2gray(I4);
I4 = double(I4);
a = [1 -1];
l = length(a);
[m, n] = size(I4);
p = zeros(m,n);
for k = 1:m
    for i = 1:n-l
            p(k,1:2)=I4(k,1:2);
        for j = 1:l
            p(k,i+2) = p(k,i+2)+a(j).*I4(k,i+j-1);
        end
    end
end
axes(handles.axes2);
imshow(p)


% --- Executes on button press in AddLight.
function AddLight_Callback(hObject, eventdata, handles)
% hObject    handle to AddLight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I= getappdata(handles.axes2, 'Ima')
I= im2double(I);
I1= 1.* I + 50/255;
axes(handles.axes2);
imshow(I1);

% --- Executes on button press in FaceDetect.
function FaceDetect_Callback(hObject, eventdata, handles)
% hObject    handle to FaceDetect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I4 = getappdata(handles.axes1,'Ima');
I4 = rgb2gray(I4);
[n1,n2] = size(I4);
h = ones(9)/81;
I4 = uint8(conv2(I4,h));
BW = imbinarize(I4);
B = ones(21);%�ṹԪ��
BW = -imerode(BW,B) + BW;
BW = bwmorph(BW,'thicken');
BW = not(bwareaopen(not(BW), 300));
B = strel('line',50,90);
BW = imdilate(BW,B);
BW = imerode(BW,B);
B = strel('line',10,0);
BW = imerode(BW,B);
div = 10;
r = floor(n1/div);%�ֳ�10�� ��
c = floor(n2/div);%�ֳ�10�� ��
x1 = 1;x2 = r;%��Ӧ�г�ʼ��
s = r*c;%�����
%�ж������Ƿ���ͼƬ���ܣ�������Ǿ�ȫ��Ū��
%figure
for i=1:div
    y1 = 1;y2 = c;%��Ӧ�г�ʼ��
    for j=1:div
        loc = find(BW(x1:x2,y1:y2)==0);%ͳ����һ���ɫ���ص�λ��
        num = length(loc);
        rate = num*100/s;%ͳ�ƺ�ɫ����ռ��
        if (y2<=0.2*div*c||y2>=0.8*div*c)||(x1<=r||x2>=r*div)
            if rate <=100
                BW(x1:x2,y1:y2) = 0;
            end
            %imshow(BW)
        else
            if rate <=25
                BW(x1:x2,y1:y2) = 1;
            end
            %imshow(BW)
        end%��һ��
        y1 = y1 + c;
        y2 = y2 + c;
    end%��һ��
    x1 = x1 + r;
    x2 = x2 + r;
end
 
L = bwlabel(BW,8);%����belabel������8��ͨ��������б��
BB = regionprops(L,'BoundingBox');%�õ����ο򣬿���ÿһ����ͨ��
BB = cell2mat(struct2cell(BB));
[s1,s2] = size(BB);
BB = reshape(BB,4,s1*s2/4)';
pickshape = BB(:,3)./BB(:,4);%
shapeind = BB(0.3<pickshape&pickshape<3,:);%ɸѡ���ߴ�������ϸ�
[~,arealind] = max(shapeind(:,3).*shapeind(:,4));
axes(handles.axes2);
imshow(I4)
hold on
rectangle('Position',[shapeind(arealind,1),shapeind(arealind,2),shapeind(arealind,3),shapeind(arealind,3)],...
    'EdgeColor','g','Linewidth',2)




function Parameter_Callback(hObject, eventdata, handles)
% hObject    handle to Parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Parameter as text
%        str2double(get(hObject,'String')) returns contents of Parameter as a double
num=str2num(get(hObject,'String'));
setappdata(handles.axes2, 'num', num)


% --- Executes during object creation, after setting all properties.
function Parameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');
cla(handles.axes3,'reset');



% --- Executes on selection change in EdgeDetection.
function EdgeDetection_Callback(hObject, eventdata, handles)
% hObject    handle to EdgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns EdgeDetection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EdgeDetection

list = get(handles.EdgeDetection,'string');  %�õ�cell�������еĲ˵�ֵ
index = get(handles.EdgeDetection,'value');  %�õ���ǰGUIѡ���ֵ������
Detector = char(list(index)); 

Ima=getappdata(handles.axes1,'Ima');

if length(size(Ima))>=3
   Ima=rgb2gray(Ima); %��ͼ��ת��Ϊ�Ҷ�ͼ�� 
end
  
switch Detector
       
      case 'sobel'
         axes(handles.axes2);
         bw=edge(Ima,'sobel');
         bw=1-bw;
         imshow(bw);  
       
      case 'prewitt'
         axes(handles.axes2);
         bw=edge(Ima,'prewitt');
         imshow(bw);  
         
      case 'roberts'
         axes(handles.axes2);
         bw=edge(Ima,'roberts');
          bw=1-bw;
         imshow(bw);  
      case 'log'
         axes(handles.axes2);
         bw=edge(Ima,'log');
         imshow(bw);        
          
end

% --- Executes during object creation, after setting all properties.
function EdgeDetection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EdgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in addNoise.
function addNoise_Callback(hObject, eventdata, handles)
% hObject    handle to addNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns addNoise contents as cell array
%        contents{get(hObject,'Value')} returns selected item from addNoise

list = get(handles.addNoise,'string');  %�õ�cell�������еĲ˵�ֵ
index = get(handles.addNoise,'value');  %�õ���ǰGUIѡ���ֵ������
Ima=getappdata(handles.axes1, 'Ima');

switch index
       
    case 2
       P = str2double(inputdlg('��������������P��0<P<1'));
       Ima=imnoise(Ima,'gaussian',P);
       axes(handles.axes2); 
       imshow(Ima)
       setappdata(handles.axes2, 'Ima', Ima)
       
    case 3
       P = str2double(inputdlg('��������������P��0<P<1'));
       Ima=imnoise(Ima,'speckle',P);
       axes(handles.axes2); 
       imshow(Ima)
       setappdata(handles.axes2, 'Ima', Ima)
        
        
    case 4
        P = str2double(inputdlg('��������������P��0<P<1'));
       Ima=imnoise(Ima,'salt & pepper',P);
       axes(handles.axes2); 
       imshow(Ima)
       setappdata(handles.axes2, 'Ima', Ima)  
end

% --- Executes during object creation, after setting all properties.
function addNoise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to addNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
