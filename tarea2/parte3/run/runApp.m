function ret = runApp()
  [dir, name, ext] = fileparts( mfilename('fullpathext') );
  global _tarea2BasePath = dir;
  global _tarea2ImgPath = [dir filesep() 'img'];
  addpath([dir filesep() "libs" ]);
  addpath([dir filesep() "fcn" ]);
  addpath([dir filesep() "wnd" ]);
  waitfor(MainMenu().figure);
end
