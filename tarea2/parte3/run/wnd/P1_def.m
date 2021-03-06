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

## @deftypefn  {} {} BLoad_doIt (@var{src}, @var{data}, @var{P1})
##
## Define a callback for default action of BLoad control.
##
## @end deftypefn
function BLoad_doIt(src, data, P1)

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor
global image_full_path;
global I;

[fname, fpath, fltidx] = uigetfile();

image_full_path = fullfile(fpath, fname);

set(P1.ImageRoute, 'String', image_full_path);
set(P1.F1, 'Enable', 'on');
set(P1.F2, 'Enable', 'on');
set(P1.F3, 'Enable', 'on');

set(P1.F1,'BackgroundColor',[0.941 0.941 0.941]);
set(P1.F2,'BackgroundColor',[0.941 0.941 0.941]);
set(P1.F3,'BackgroundColor',[0.941 0.941 0.941]);
end

## @deftypefn  {} {} F1_doIt (@var{src}, @var{data}, @var{P1})
##
## Define a callback for default action of F1 control.
##
## @end deftypefn
function F1_doIt(src, data, P1)

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor
global image_full_path;
global I;

I = imread(image_full_path);
axes(P1.Results);
imshow(I);

set(P1.BDownload, 'Enable', 'on');
set(P1.BDownload,'BackgroundColor',[0.941 0.941 0.941])

end

## @deftypefn  {} {} F2_doIt (@var{src}, @var{data}, @var{P1})
##
## Define a callback for default action of F2 control.
##
## @end deftypefn
function F2_doIt(src, data, P1)

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor
global image_full_path;
global I;

I = imread(image_full_path);
disp('Iniciando filtrado');
I = fast_median_filter(I);
disp('Filtrado finalizado');
axes(P1.Results);
imshow(I);

set(P1.BDownload, 'Enable', 'on');
set(P1.BDownload,'BackgroundColor',[0.941 0.941 0.941])
end

## @deftypefn  {} {} F3_doIt (@var{src}, @var{data}, @var{P1})
##
## Define a callback for default action of F3 control.
##
## @end deftypefn
function F3_doIt(src, data, P1)

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor
global image_full_path;
global I;

I = imread(image_full_path);
disp('Iniciando filtrado');
I = md_median_filter(I);
disp('Filtrado finalizado');
axes(P1.Results);
imshow(I);

set(P1.BDownload, 'Enable', 'on');
set(P1.BDownload,'BackgroundColor',[0.941 0.941 0.941])
end

## @deftypefn  {} {} BDownload_doIt (@var{src}, @var{data}, @var{P1})
##
## Define a callback for default action of BDownload control.
##
## @end deftypefn
function BDownload_doIt(src, data, P1)

% El c?digo que se indique aqu? ser? ejecutado cuando el usuario presione en el bot?n.
% Por defecto, todos los eventos est?n desactivdados, para activarlos debe activar
% propertie 'generateCallback' from the properties editor
global I;

[file,path,indx] = uiputfile('imagen_salida.png');


imwrite(I, fullfile(path, file));
end

 
## @deftypefn  {} {@var{ret} = } show_P1()
##
## Create windows controls over a figure, link controls with callbacks and return 
## a window struct representation.
##
## @end deftypefn
function ret = show_P1()
  _scrSize = get(0, "screensize");
  _xPos = (_scrSize(3) - 669)/2;
  _yPos = (_scrSize(4) - 591)/2;
   P1 = figure ( ... 
	'Color', [0.941 0.941 0.941], ...
	'Position', [_xPos _yPos 669 591], ...
	'resize', 'off', ...
	'windowstyle', 'normal', ...
	'MenuBar', 'none');
	 set(P1, 'visible', 'off');
  GroupPanel_1 = uipanel( ...
	'parent',P1, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 452 640 54], ... 
	'title', 'Operaciones', ... 
	'TitlePosition', 'lefttop');
  Button_7 = uicontrol( ...
	'parent',GroupPanel_1, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [30 -78 189 22], ... 
	'String', 'Filtro FMFA', ... 
	'TooltipString', '');
  Label_2 = uicontrol( ...
	'parent',P1, ... 
	'Style','text', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [15 557 152 19], ... 
	'String', 'Filtrado de im?genes', ... 
	'TooltipString', '');
  BLoad = uicontrol( ...
	'parent',P1, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 518 137 28], ... 
	'String', 'Cargar imagen', ... 
	'TooltipString', '');
  ImageRoute = uicontrol( ...
	'parent',P1, ... 
	'Style','edit', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [1.000 1.000 1.000], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'HorizontalAlignment', 'left', ... 
	'Position', [160 519 497 22], ... 
	'String', '', ... 
	'TooltipString', '');
  F1 = uicontrol( ...
	'parent',P1, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.678 0.678 0.678], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [25 464 189 22], ... 
	'String', 'Filtro Mediana', ... 
	'TooltipString', '');
  F2 = uicontrol( ...
	'parent',P1, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.686 0.686 0.686], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [240 464 189 22], ... 
	'String', 'Filtro FMFA', ... 
	'TooltipString', '');
  F3 = uicontrol( ...
	'parent',P1, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.686 0.686 0.686], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [450 464 189 22], ... 
	'String', 'Filtro HPDBMF', ... 
	'TooltipString', '');
  Results = uipanel( ...
	'parent',P1, ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.941 0.941 0.941], ... 
	'BorderWidth', 1, ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 56 640 385], ... 
	'title', 'Resultado', ... 
	'TitlePosition', 'lefttop');
  BDownload = uicontrol( ...
	'parent',P1, ... 
	'Style','pushbutton', ... 
	'Units', 'pixels', ... 
	'BackgroundColor', [0.686 0.686 0.686], ... 
	'FontAngle', 'normal', ... 
	'FontName', 'Arial', ... 
	'FontSize', 10, 'FontUnits', 'points', ... 
	'FontWeight', 'normal', ... 
	'ForegroundColor', [0.000 0.000 0.000], ... 
	'Position', [15 11 640 35], ... 
	'String', 'Descargar imagen', ... 
	'TooltipString', '');

  P1 = struct( ...
      'figure', P1, ...
      'GroupPanel_1', GroupPanel_1, ...
      'Button_7', Button_7, ...
      'Label_2', Label_2, ...
      'BLoad', BLoad, ...
      'ImageRoute', ImageRoute, ...
      'F1', F1, ...
      'F2', F2, ...
      'F3', F3, ...
      'Results', Results, ...
      'BDownload', BDownload);


  set (BLoad, 'callback', {@BLoad_doIt, P1});
  set (F1, 'callback', {@F1_doIt, P1});
  set (F2, 'callback', {@F2_doIt, P1});
  set (F3, 'callback', {@F3_doIt, P1});
  set (BDownload, 'callback', {@BDownload_doIt, P1});
  dlg = struct(P1);

%
% El c?digo fuente escrito aqu? ser? ejecutado cuando
% la ventana se haga visible. Funciona como el evento 'onLoad' de otros lenguajes.
%

pkg load image;


set(P1.BDownload, 'Enable', 'off');

set(P1.F1, 'Enable', 'off');
set(P1.F2, 'Enable', 'off');
set(P1.F3, 'Enable', 'off');



  set(P1.figure, 'visible', 'on');
  ret = P1;
end

