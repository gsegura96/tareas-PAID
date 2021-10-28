clear
clc
close all
pkg load image



A = imread ('tigre.png');
subplot(1,3,1)
imshow(A)

[h, w, dim] = size(A);
B = zeros(h, w);
C = zeros(h, w);


for i = 2:h-1
  col1 = median([A(i-1,1),A(i,1),A(i+1,1)]);
  col2 = median([A(i-1,2),A(i,2),A(i+1,2)]);
  for j = 3:w-1
    col3 = median([A(i-1,j),A(i,j),A(i+1,j)]);
    B(i,j) = median([col1,col2,col3]);
    col1 = col2;
    col2 = col3;
  endfor
endfor

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

for i = 2:h-1
  for j = 2:w-1
    pixel = A(i, j);
    if pixel == 0 || pixel == 255;
      M1 = mvdm(A(i-1,j-1),A(i-1,j),A(i-1,j+1));
      M2 = mvdm(A(i,j-1),A(i,j),A(i,j+1));
      M3 = mvdm(A(i+1,j-1),A(i+1,j),A(i+1,j+1));
      median_value = mvdm(M1,M2,M3);
      disp("bie")
      if median_value == 0 || median_value == 255;
        disp("blanco")
      endif
      C(i,j) = median_value;
    else
      C(i,j) = pixel;
    endif
  endfor
endfor

C = uint8(C);
subplot(1,3,2)
imshow(C)

##C = uint8(C);
##subplot(1,3,3)
##imshow(B)




