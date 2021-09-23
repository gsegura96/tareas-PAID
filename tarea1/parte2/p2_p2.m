clear;
clc;
close all;
pkg load image;

rand ("seed", 5);

load output_img
load message_bin_seed_5

input_img = imread("WingedFigure.jpg");
input_img = input_img(:, :, 1);

[M N] = size(input_img);
rows = floor(M / 4);
cols = floor(N / 4);

T = 20;
size(message_bin)

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
size(message_bin)

disp("NPSR");
psnr(message_bin_recovered,message_bin)

bits_exitosos=sum(sum(message_bin == message_bin_recovered))/size(message_bin_recovered(:))(1)*100;
disp("% bits exitosos");
disp( bits_exitosos);

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


rand ("seed", 5);
message_size = floor((rows * cols) / 8);
message_orig = uint8(rand([1 message_size]) * 255);


numeros_exitosos=sum(sum(message_orig == message_int))/size(message_int(:))(1)*100;
disp("% numeros exitosos");
disp( numeros_exitosos);
