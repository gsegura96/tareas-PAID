%Funcion de calculo de media para HPDBMF

  
% High Performance Modified Decision Based Median Filter Algorithm

 
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