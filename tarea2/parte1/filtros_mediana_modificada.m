clear;
clc;
close all;
pkg load image;
pkg load video;

V = VideoReader('video.mp4')
ruido = VideoWriter('video_con_ruido.mp4');
video1 = VideoWriter('video_sin_ruido_alg1.mp4');
video2 = VideoWriter('video_sin_ruido_alg2.mp4');
fr = V.NumberOfFrames
m = V.Height
n = V.Width

Y = uint8(zeros(m,n,1,fr));
for k=1:fr
  A = readFrame(V);
  Y(:,:,1,k) = A(:,:,1 ); 
  Y(:,:,1,k) = imnoise(Y(:,:,1,k),"salt & pepper");
endfor
 
Y1 = uint8(zeros(m,n,1,fr));
Y2 = uint8(zeros(m,n,1,fr));

%Funcion de calculo de media para HPDBMF
function median_value = mvdm(x, y, z)
  vector = [x, y, z];
  sorted_vector = sort(vector);
  if (vector(2) == 0)
    median_value = vector(3);
  elseif (vector(2) == 255)
    median_value = vector(1);
  else
    median_value = vector(2);
  endif
endfunction
  
% High Performance Modified Decision Based Median Filter Algorithm
function Y2 = md_median_filter(Y)
  [m,n] = size(Y);
  Y2 = uint8(zeros(m,n,1));
  
  %Esquina superior izquierda
  x = 1; y = 1;
  vecAux = [Y(x, y+1) Y(x+1, y) Y(x+1, y+1) Y(x,y)];
  Y2(x,y) = median(vecAux);

  %Esquina superior derecha
  x = 1; y = n;
  vecAux = [Y(x, y-1) Y(x+1, y-1) Y(x+1, y) Y(x,y)];
  Y2(x,y) = median(vecAux);

  %Esquina inferior izquierda
  x = m; y = 1;
  vecAux = [Y(x-1, y) Y(x-1, y+1) Y(x, y+1) Y(x,y)];
  Y2(x,y) = median(vecAux);

  %Esquina inferior derecha
  x = m; y = n;
  vecAux = [Y(x-1, y-1) Y(x-1, y) Y(x, y-1) Y(x,y)];
  Y2(x,y) = median(vecAux);

  %Bordes superior e inferior
  for x = 1:m
    for y = 2:n-1
      %Borde superior
      if (x == 1)
      Bloque = Y(x:x+1, y-1:y+1);
      vecAux = Bloque(:);
      Y2(x,y) = median(vecAux);
      endif
      
      %Borde inferior
      if (x == m)
      Bloque = Y(x-1:x, y-1:y+1);
      vecAux = Bloque(:);
      Y2(x,y) = median(vecAux);
      endif
    endfor
  endfor

  %Bordes izquierda y derecha
  for x = 2:m-1
    for y = 1:n 
      %Borde izquierdo
      if (y == 1)
      Bloque = Y(x-1:x+1, y:y+1);
      vecAux = Bloque(:);
      Y2(x,y) = median(vecAux);
      endif
      
      %Borde derecho
      if (y == n)
      Bloque = Y(x-1:x+1, y-1:y);
      vecAux = Bloque(:);
      Y2(x,y) = median(vecAux);
      endif
    endfor
  endfor

  %Parte Central de imagen 
  last_procesed_pixel = 0;
  for i = 2:m-1
    for j = 2:n-1
      pixel = Y(i, j);
      if pixel == 0 || pixel == 255;
        M1 = mvdm(Y(i-1,j-1),Y(i-1,j),Y(i-1,j+1));
        M2 = mvdm(Y(i,j-1),Y(i,j),Y(i,j+1));
        M3 = mvdm(Y(i+1,j-1),Y(i+1,j),Y(i+1,j+1));
        median_value = mvdm(M1,M2,M3);
        if median_value == 0 || median_value == 255;
          if (i >= 3 && i <= m-3 && j >= 3 && i <= n-3)
            M1 = median([Y(i-2,j-2),Y(i-2,j-1),Y(i-2,j),Y(i-2,j+1),Y(i-2,j+2)]);
            M2 = median([Y(i-1,j-2),Y(i-1,j-1),Y(i-1,j),Y(i-1,j+1),Y(i-1,j+2)]);
            M3 = median([Y(i,j-2),Y(i,j-1),Y(i,j),Y(i,j+1),Y(i,j+2)]);
            M4 = median([Y(i+1,j-2),Y(i+1,j-1),Y(i+1,j),Y(i+1,j+1),Y(i+1,j+2)]);
            M5 = median([Y(i+2,j-2),Y(i+2,j-1),Y(i+2,j),Y(i+2,j+1),Y(i+2,j+2)]);
            median_value = median([M1,M2,M3,M4,M5]);
            Y2(i,j) = median_value;
          else
            Y2(i,j) = last_procesed_pixel;
          endif
        else
          Y2(i,j) = median_value;
          last_procesed_pixel = median_value;
        endif
      else
        Y2(i,j) = pixel;
        last_procesed_pixel = pixel;
      endif
    endfor
  endfor
endfunction
 
% Fast Median Filter Aproximation
function Y1 = fast_median_filter(Y)
  [m,n] = size(Y);
  Y1 = uint8(zeros(m,n,1));

  %Esquina superior izquierda
  x = 1; y = 1;
  vecAux = [Y(x, y+1) Y(x+1, y) Y(x+1, y+1) Y(x,y)];
  Y1(x,y) = median(vecAux);

  %Esquina superior derecha
  x = 1; y = n;
  vecAux = [Y(x, y-1) Y(x+1, y-1) Y(x+1, y) Y(x,y)];
  Y1(x,y) = median(vecAux);

  %Esquina inferior izquierda
  x = m; y = 1;
  vecAux = [Y(x-1, y) Y(x-1, y+1) Y(x, y+1) Y(x,y)];
  Y1(x,y) = median(vecAux);

  %Esquina inferior derecha
  x = m; y = n;
  vecAux = [Y(x-1, y-1) Y(x-1, y) Y(x, y-1) Y(x,y)];
  Y1(x,y) = median(vecAux);

  %Bordes superior e inferior
  for x = 1:m
    for y = 2:n-1
      %Borde superior
      if (x == 1)
      Bloque = Y(x:x+1, y-1:y+1);
      vecAux = Bloque(:);
      Y1(x,y) = median(vecAux);
      endif
      
      %Borde inferior
      if (x == m)
      Bloque = Y(x-1:x, y-1:y+1);
      vecAux = Bloque(:);
      Y1(x,y) = median(vecAux);
      endif
    endfor
  endfor

  %Bordes izquierda y derecha
  for x = 2:m-1
    for y = 1:n 
      %Borde izquierdo
      if (y == 1)
      Bloque = Y(x-1:x+1, y:y+1);
      vecAux = Bloque(:);
      Y1(x,y) = median(vecAux);
      endif
      
      %Borde derecho
      if (y == n)
      Bloque = Y(x-1:x+1, y-1:y);
      vecAux = Bloque(:);
      Y1(x,y) = median(vecAux);
      endif
    endfor
  endfor

  %Parte Central de imagen
  for i = 2:m-1
    col1 = median([Y(i-1,1),Y(i,1),Y(i+1,1)]);
    col2 = median([Y(i-1,2),Y(i,2),Y(i+1,2)]);
    %Calculo de medias
    for j = 3:n-1
      col3 = median([Y(i-1,j),Y(i,j),Y(i+1,j)]);
      Y1(i,j) = median([col1,col2,col3]);
      col1 = col2;
      col2 = col3;
    endfor
  endfor
endfunction
tic
for k=1:fr
  k
  %llamada a los algoritmos de filtrado
  Y1(:,:,1,k) = fast_median_filter(Y(:,:,1,k));
  Y2(:,:,1,k) = md_median_filter(Y(:,:,1,k));

##  subplot(1,3,1)
##  imshow(uint8(Y(:,:,:,k)));
##  subplot(1,3,2)
##  imshow(uint8(Y1(:,:,:,k)));
##  subplot(1,3,2)
##  imshow(uint8(Y2(:,:,:,k)));
##  pause(1);
  
  %escritura de videos
  writeVideo(ruido, Y(:,:,k));
  writeVideo(video1, Y1(:,:,k));
  writeVideo(video2, Y2(:,:,k));
endfor
toc
close(ruido);
close(video1);
close(video2);



