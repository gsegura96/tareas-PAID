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

 
## @deftypefn  {} {@var{ret} = } show_P2()
##
## Create windows controls over a figure, link controls with callbacks and return 
## a window struct representation.
##
## @end deftypefn
function ret = show_P2()
  _scrSize = get(0, "screensize");
  _xPos = (_scrSize(3) - 234)/2;
  _yPos = (_scrSize(4) - 54)/2;
   P2 = figure ( ... 
	'Color', [0.941 0.941 0.941], ...
	'Position', [_xPos _yPos 234 54], ...
	'resize', 'off', ...
	'windowstyle', 'normal', ...
	'MenuBar', 'none');
	 set(P2, 'visible', 'off');

  P2 = struct( ...
      'figure', P2);


  dlg = struct(P2);

%
% El código fuente escrito aquí será ejecutado cuando
% la ventana se haga visible. Funciona como el evento 'onLoad' de otros lenguajes.
%

  set(P2.figure, 'visible', 'on');
  ret = P2;
end

