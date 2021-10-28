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
  
function Y2 = md_median_filter(Y)
  [m,n] = size(Y);
  Y2 = uint8(zeros(m,n,1));
  for i = 2:m-1
    for j = 2:n-1
      pixel = Y(i, j);
      if pixel == 0 || pixel == 255;
        M1 = mvdm(Y(i-1,j-1),Y(i-1,j),Y(i-1,j+1));
        M2 = mvdm(Y(i,j-1),Y(i,j),Y(i,j+1));
        M3 = mvdm(Y(i+1,j-1),Y(i+1,j),Y(i+1,j+1));
        median_value = mvdm(M1,M2,M3);
        if median_value == 0 || median_value == 255;
          M1 = median([Y(i-2,j-2),Y(i-2,j-1),Y(i-2,j),Y(i-2,j+1),Y(i-2,j+2)]);
          M2 = median([Y(i-1,j-2),Y(i-1,j-1),Y(i-1,j),Y(i-1,j+1),Y(i-1,j+2)]);
          M3 = median([Y(i,j-2),Y(i,j-1),Y(i,j),Y(i,j+1),Y(i,j+2)]);
          M4 = median([Y(i+1,j-2),Y(i+1,j-1),Y(i+1,j),Y(i+1,j+1),Y(i+1,j+2)]);
          M5 = median([Y(i+2,j-2),Y(i+2,j-1),Y(i+2,j),Y(i+2,j+1),Y(i+2,j+2)]);
          median_value = median([M1,M2,M3,M4,M5]);
          Y2(i,j) = median_value;
        elseif
          Y2(i,j) = median_value;
        endif
      else
        Y2(i,j) = pixel;
      endif
    endfor
  endfor
endfunction
 
function Y1 = fast_median_filter(Y)
  [m,n] = size(Y);
  Y1 = uint8(zeros(m,n,1));
  for i = 2:m-1
    col1 = median([Y(i-1,1),Y(i,1),Y(i+1,1)]);
    col2 = median([Y(i-1,2),Y(i,2),Y(i+1,2)]);
    for j = 3:n-1
      col3 = median([Y(i-1,j),Y(i,j),Y(i+1,j)]);
      Y1(i,j) = median([col1,col2,col3]);
      col1 = col2;
      col2 = col3;
    endfor
  endfor
endfunction

for k=1:fr
  k

  Y1(:,:,1,k) = fast_median_filter(Y(:,:,1,k));
  Y2(:,:,1,k) = md_median_filter(Y(:,:,1,k));

  subplot(1,3,1)
  imshow(uint8(Y(:,:,:,k)));
  subplot(1,3,2)
  imshow(uint8(Y1(:,:,:,k)));
  subplot(1,3,2)
  imshow(uint8(Y2(:,:,:,k)));
  pause(1);
  writeVideo(ruido, Y(:,:,k));
  writeVideo(video1, Y1(:,:,k));
  writeVideo(video2, Y2(:,:,k));
endfor
close(ruido);
close(video1);
close(video2);



