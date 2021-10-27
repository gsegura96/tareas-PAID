clear;
clc;
close all;
pkg load image;
pkg load video;

V = VideoReader('video_con_ruido.mp4')
video = VideoWriter('video_sin_ruido_alg1.mp4');
fr = V.NumberOfFrames
m = V.Height
n = V.Width
 
Y = uint8(zeros(m,n,1,fr));

for k=1:fr
  A = readFrame(V);
  k
  for i = 2:m-1
    col1 = median([A(i-1,1),A(i,1),A(i+1,1)]);
    col2 = median([A(i-1,2),A(i,2),A(i+1,2)]);
    for j = 3:n-1
      col3 = median([A(i-1,j),A(i,j),A(i+1,j)]);
      Y(i,j,k) = median([col1,col2,col3]);
      col1 = col2;
      col2 = col3;
    endfor
  endfor
##  imshow(uint8(Y(:,:,:,k)));
##  pause(0.001);
  writeVideo(video, Y(:,:,k));
endfor
close(video);
