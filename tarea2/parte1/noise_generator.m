clear;
clc;
close all;
pkg load image
pkg load video

V = VideoReader('video_inicial.mp4')
fr = V.NumberOfFrames
m = V.Height
n = V.Width

Y = zeros(m,n,3,fr);

% Procesamiento video
for k = 1:fr
  ZI = readFrame(V);
  Y(:,:,1:K) = 255 - ZI(:,:,1);
  Y(:,:,2:K) = 255 - ZI(:,:,2);
  Y(:,:,3:K) = 255 - ZI(:,:,3);
endfor

% Guardar Video
video = VideoWriter('video_con_ruido.mp4');
for i=1:fr
  writeVideo(video, Y(:,:,i));
endfor

close(video);