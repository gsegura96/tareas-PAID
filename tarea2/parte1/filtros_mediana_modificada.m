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



for k=1:fr
##  imshow(uint8(Y(:,:,k)));
##  pause(0.001);
  k
  
  for i = 2:m-1
    for j = 2:n-1
      pixel = Y(i, j, k);
      if pixel == 0 || pixel == 255;
        M1 = mvdm(Y(i-1,j-1,k),Y(i-1,j,k),Y(i-1,j+1,k));
        M2 = mvdm(Y(i,j-1,k),Y(i,j,k),Y(i,j+1,k));
        M3 = mvdm(Y(i+1,j-1,k),Y(i+1,j,k),Y(i+1,j+1,k));
        median_value = mvdm(M1,M2,M3);
        if median_value == 0 || median_value == 255;
          disp("blanco")
        elseif
          Y2(i,j,k) = median_value;
        endif
      else
        Y2(i,j,k) = pixel;
      endif
    endfor
  endfor
  
  for i = 2:m-1
    col1 = median([Y(i-1,1,k),Y(i,1,k),Y(i+1,1,k)]);
    col2 = median([Y(i-1,2,k),Y(i,2,k),Y(i+1,2,k)]);
    for j = 3:n-1
      col3 = median([Y(i-1,j,k),Y(i,j,k),Y(i+1,j,k)]);
      Y1(i,j,k) = median([col1,col2,col3]);
      col1 = col2;
      col2 = col3;
    endfor
  endfor

  subplot(1,3,1)
  imshow(uint8(Y(:,:,:,k)));
  subplot(1,3,2)
  imshow(uint8(Y1(:,:,:,k)));
  subplot(1,3,2)
  imshow(uint8(Y2(:,:,:,k)));
  pause(0.001);
  writeVideo(ruido, Y(:,:,k));
  writeVideo(video1, Y1(:,:,k));
  writeVideo(video2, Y2(:,:,k));
endfor
close(ruido);
close(video1);
close(video2);



