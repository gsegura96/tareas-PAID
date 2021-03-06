clear;
clc;
close all;
pkg load image
pkg load video

V = VideoReader('paid2.mp4')
##fr = V.NumberOfFrames
fr = floor(V.Duration*V.FrameRate);
m = V.Height
n = V.Width

new_m = 320
new_n = 480

Y = uint8(zeros(new_m,new_n,1,fr));
%Y = uint8(zeros(m,n,3,fr));

% Procesamiento video
for k = 1:fr-15;
  ZI = rgb2gray(imresize(readFrame(V),[new_m,new_n]));
  Y(:,:,1,k) = ZI(:,:,:);
##  Y(:,:,1,k) = 255 - ZI(:,:,1);
##  Y(:,:,2,k) = 255 - ZI(:,:,2);
##  Y(:,:,3,k) = 255 - ZI(:,:,3);
endfor

for k = 1:fr-15;
##  Y(:,:,1,k) = imnoise(Y(:,:,:),"salt & pepper");
  imshow(uint8(Y(:,:,:,k)));
  pause(0.001);
endfor

% Guardar Video
video = VideoWriter('video.mp4');
for i=1:fr-15;
  writeVideo(video, Y(:,:,1,i));
endfor
close(video);