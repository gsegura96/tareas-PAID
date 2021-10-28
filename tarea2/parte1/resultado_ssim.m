clc; clear
pkg load image
pkg load video

VidLimp = VideoReader('video_limpio.mp4'); %Carga video
VidMed = VideoReader('video_sin_ruido_1.mp4');
VidIAMFA = VideoReader('video_sin_ruido_2.mp4');

fr1 = VidLimp.NumberOfFrames;
fr2 = VidMed.NumberOfFrames;
fr3 = VidIAMFA.NumberOfFrames;

ssim1 = 0;
ssim2 = 0;
ssim3 = 0;

for i=1:fr2
  Z1 = readFrame(VidLimp);                                %Frames video Original 
  Z2 = readFrame(VidMed);                                 %Frames video Mediana  
  Z3 = readFrame(VidIAMFA);                               %Frames video IAMFA-I
  
  %Video Original
  [mssim1Z11R, ssim_map] = ssim(Z1(:,:,1), Z1(:,:,1));
  [mssim1Z11G, ssim_map] = ssim(Z1(:,:,2), Z1(:,:,2));
  [mssim1Z11B, ssim_map] = ssim(Z1(:,:,3), Z1(:,:,3));
  A1 = (mssim1Z11R+mssim1Z11G+mssim1Z11B)/3;
  ssim1 += A1;   %SSIM entre video original-original
  
  %Video Mediana
  [mssim1Z12R, ssim_map] = ssim(Z1(:,:,1), Z2(:,:,1));
  [mssim1Z12G, ssim_map] = ssim(Z1(:,:,2), Z2(:,:,2));
  [mssim1Z12B, ssim_map] = ssim(Z1(:,:,3), Z2(:,:,3));
  A2 = (mssim1Z12R+mssim1Z12G+mssim1Z12B)/3;
  ssim2 += A2;   %SSIM entre video original-mediana
  
  %Video IAMFA-1
  [mssim1Z13R, ssim_map] = ssim(Z1(:,:,1), Z3(:,:,1));
  [mssim1Z13G, ssim_map] = ssim(Z1(:,:,2), Z3(:,:,2));
  [mssim1Z13B, ssim_map] = ssim(Z1(:,:,3), Z3(:,:,3));
  A3 = (mssim1Z13R+mssim1Z13G+mssim1Z13B)/3;
  ssim3 += A3;   %SSIM entre video original-IAMFA-I
endfor

ssim1 /= fr1;
ssim2 /= fr2;
ssim3 /= fr3;

disp("SSIM entre frames de video original con video original:")
disp(ssim1)

disp("SSIM entre frames de video original con video filtrado con mediana:")
disp(ssim2)

disp("SSIM entre frames de video original con video filtrado con IAMFA-I:")
disp(ssim3)



