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
          if (i >= 3 && i <= m-3 && j >= 3 && j <= n-3)
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