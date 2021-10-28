## -*- texinfo -*-
## @deftypefn  {} {} dummy()
##
## This is a dummy function documentation. This file have a lot functions
## and each one have a little documentation. This text is to avoid a warning when
## install this file as part of package.
## @end deftypefn
##
## Set the graphics toolkit and force read this file as script file (not a function file).
##
graphics_toolkit qt;
##


##
##
## Begin callbacks definitions 
##

## @deftypefn  {} {} Button_1_doIt (@var{src}, @var{data}, @var{Main})
##
## Define a callback for default action of Button_1 control.
##
## @end deftypefn
function Button_1_doIt(src, data, Main)

% El código que se indique aquí será ejecutado cuando el usuario presione en el botón.
% Por defecto, todos los eventos están desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor

disp("Hola Mundo 2");
[fname, fpath, fltidx] = uigetfile();

image_full_path = fullfile(fpath, fname);
pkg load image;
% Filtro Ideal (Paso Bajo)
I = imread(image_full_path);
axes(Main.Image_Result);
imshow(I);

% Almacenar tamaño de la imagen
[M, N] = size(I);
  
% Calcular DFT-2D 
F = fft2(I);

% Frecuencia de corte
D0 = 30; 
  
% Calcular matriz de distancia
u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
  
[V, U] = meshgrid(v, u);
  
D = sqrt(U.^2+V.^2);
  
% Filtro ideal
H = D <= D0;
  
% Convolución
G = H.*F;


axes(Main.Image_FFT);
imshow(log(1+abs(fftshift(G))), [])
end

 
## @deftypefn  {} {@var{ret} = } show_Main()
##
## Create windows controls over a figure, link controls with callbacks and return 
## a window struct representation.
##
## @end deftypefn
function ret = show_Main()
  _scrSize = get(0, "screensize");
  _xPos = (_scrSize(3) - 1030)/2;
  _yPos = (_scrSize(4) - 772)/2;
   Main = figure ( ... 
	'Color', [0.941 0.941 0.941], ...
	'Position', [_xPos _yPos 1030 772], ...
	'resize', 'off', ...
	'windowstyle', 'normal', ...
	'MenuBar', 'none');
	 set(Main, 'visible', 'off');
  Button_1 = uicontrol( ...
	'parent',Main, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [615 402 250 217], ... 
	'String', 'Button_1', ... 
	'TooltipString', '');
  Image_Result = axes( ...
	'Units', 'pixels', ... 
	'parent',Main, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'Position', [40 326 518 361]);
  Image_FFT = axes( ...
	'Units', 'pixels', ... 
	'parent',Main, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'Position', [255 22 575 200]);

  Main = struct( ...
      'figure', Main, ...
      'Button_1', Button_1, ...
      'Image_Result', Image_Result, ...
      'Image_FFT', Image_FFT);


  set (Button_1, 'callback', {@Button_1_doIt, Main});
  dlg = struct(Main);

%
% El código fuente escrito aquí será ejecutado cuando
% la ventana se haga visible. Funciona como el evento 'onLoad' de otros lenguajes.
%

  set(Main.figure, 'visible', 'on');
  ret = Main;
end

