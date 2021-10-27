clear;
clc;
close all;
pkg load image
pkg load video

V = VideoReader('paid.mp4')
fr = V.NumberOfFrames
m = V.Height
n = V.Width

Y = uint8(zeros(m,n,3,fr));

% Procesamiento video
for k = 1:50;

  ZI = readFrame(V);
  Y(:,:,1,k) = 255 - ZI(:,:,1);
  Y(:,:,2,k) = 255 - ZI(:,:,2);
  Y(:,:,3,k) = 255 - ZI(:,:,3);

##  Y(:,:,:,k) = imnoise(ZI(:,:,:,k),"gaussian");
  imshow(uint8(Y(:,:,:,k)));
  pause(0.1);
endfor

% Guardar Video
##video = VideoWriter('video_con_ruido.mp4');
##for i=1:fr
##  writeVideo(video, Y(:,:,i));
##endfor
##
##close(video);