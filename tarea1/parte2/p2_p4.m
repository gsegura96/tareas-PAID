clear;
clc;
close all;
pkg load image;

rand ("seed", 5);

load barbara_original;
load barbara_encriptada;

input_img = Ar;
output_img = A_Stego;
[M N] = size(input_img);
rows = floor(M / 4);
cols = floor(N / 4);

T = 0.005;

message_bin_recovered=zeros(rows,cols);

for x = 1:rows
  for y = 1:cols
    Bk = output_img(1 + (4 * (x - 1)):(4 * (x)), 1 + (4 * (y - 1)):(4 * (y)));
    [U, S, V] = svd(Bk);
    new_bit=0;
    if(   (S(2,2)-S(3,3))>(T/2)    )
    new_bit=1;
  endif
      message_bin_recovered(x,y)= new_bit;
  endfor
endfor


size(message_bin_recovered)


message_int=[];

n_bits=size(message_bin_recovered(:))(1);
i=1;
while i < floor(n_bits/8)*8
new_n=0;
for nb = 7: - 1:0
new_n = new_n+message_bin_recovered(i)*(2**nb);
i=i+1;
endfor
message_int=[message_int,new_n];
endwhile


rand ("seed", 3);
message_size = floor((rows * cols) / 8);
message_orig = uint8(rand([1 message_size]) * 255);


numeros_exitosos=sum(sum(message_orig == message_int))/size(message_int(:))(1)*100;



subplot(1, 2, 1);
imshow(input_img)
title('Imagen de entrada');

subplot(1, 2, 2);
imshow(output_img)
title('Imagen de salida');


disp("% numeros exitosos");
disp( numeros_exitosos);

disp("psnr");
disp(psnr(output_img,input_img));

