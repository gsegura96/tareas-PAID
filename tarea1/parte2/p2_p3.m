clear;
clc;
close all;
pkg load image;

input_img = imread("WingedFigure.jpg");
input_img= input_img(:, :, 1);

seed=5
T =20;

function output_img = incrustar(input_img,T,  seed)
[M N] = size(input_img);
rows = floor(M / 4);
cols = floor(N / 4);
rand ("seed", seed);
message_size = floor((rows * cols) / 8);
message = uint8(rand([1 message_size]) * 255);
message_bin = [];

for e = message
    bin_arr = bitget (e, 8: - 1:1);
    message_bin = [message_bin, bin_arr];
endfor

remaining = zeros([1 mod((rows * cols), 8)]);
message_bin = reshape([message_bin, remaining], rows, cols);

output_img = [];
for x = 1:rows
    new_row = [];
    for y = 1:cols
        Bk = input_img(1 + (4 * (x - 1)):(4 * (x)), 1 + (4 * (y - 1)):(4 * (y)));
        [U, S, V] = svd(Bk);
        if (message_bin(x, y) == 1)
            if (S(3, 3) > (S(2, 2) - S(3, 3)))
                S(4, 4) = S(2, 2) - S(3, 3);
            else
                S(4, 4) = 0;
            endif
            S(2, 2) = S(2, 2) + T;
        endif
        if (S(3, 3) < S(4, 4))
            S(3, 3) = S(4, 4);
        endif
        Bke = U * (S) * V';
        new_row = horzcat(new_row, Bke);
    endfor
    output_img = vertcat(output_img, new_row);
endfor


endfunction




function message_bin_recovered = recuperar_bits(output_img,T)

[M N] = size(output_img);
rows = floor(M / 4);
cols = floor(N / 4);

T = 20;

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
endfunction


function message_int = recuperar_int(message_bin_recovered)
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

endfunction



rand ("seed", seed);
[M N] = size(input_img);
rows = floor(M / 4);
cols = floor(N / 4);
message_size = floor((rows * cols) / 8);
message_orig = uint8(rand([1 message_size]) * 255);


numeros_exitosos=[]
psnr_=[]

for T= 5:5:200
output_img2 = incrustar(input_img, T, seed);
output_img2=uint8(output_img2);
message_bin_recovered2=recuperar_bits(output_img2,T);
message_int = recuperar_int(message_bin_recovered2);
numeros_exitosos=[numeros_exitosos, sum(sum(message_orig == message_int))/size(message_int(:))(1)*100];
psnr_=[psnr_,psnr(output_img2,input_img)];
endfor



x = 5:5:200;
subplot(1, 2, 1);
plot (x, numeros_exitosos);
xlabel ("T");
ylabel ("% exito");
subplot(1, 2, 2);
plot (x, psnr_);
xlabel ("T");
ylabel ("PSNR");

