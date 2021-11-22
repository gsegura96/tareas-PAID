clc; clear; 
close all;
pkg load image;




function [transformed_image] = image_transformation_2x2(I_color)
[M N ~] = size(I_color);
transformed_image = zeros(2*M,2*N);
for i = 1:M
    for j = 1:N
        I=0.3*I_color(i,j,1)+0.59*I_color(i,j,2)+0.11*I_color(i,j,3);
        transformed_image((2*i-1):(2*i) , (2*j-1):(2*j))=[I I_color(i,j,1) ; I_color(i,j,2) I_color(i,j,3)];
    end
end
% transformed_image = uint8(transformed_image);
endfunction


function [original_image] = image_transformation_2x2_inverse(transformed_image)
[M N ~] = size(transformed_image);
I_color = zeros(M/2,N/2,3);
for i = 1:M/2
    for j = 1:N/2
        I_color(i,j,1)=transformed_image((2*i-1):(2*i) , (2*j-1):(2*j))(1,2);
        I_color(i,j,2)=transformed_image((2*i-1):(2*i) , (2*j-1):(2*j))(2,1);
        I_color(i,j,3)=transformed_image((2*i-1):(2*i) , (2*j-1):(2*j))(2,2);
    end
end

% original_image = uint8(I_color);
original_image = I_color;

endfunction



function [transformed_image] = image_transformation_2x3(I_color)
[M N ~] = size(I_color);
transformed_image = zeros(2*M,(3*N/2));
for i = 1:M
    for j = 1:2:N
        current_j=(j+1)/2;
        new_block=zeros(2,3);
        new_block(1,:)=[I_color(i,j,1), I_color(i,j,2), I_color(i,j+1,3)];
        new_block(2,:)=[I_color(i,j,3), I_color(i,j+1,1), I_color(i,j+1,2)];
        transformed_image((2*i-1):(2*i) , (3*(current_j)-2):(3*current_j))=new_block;
    end
end
% transformed_image=uint8(transformed_image);
endfunction

function [original_image] = image_transformation_2x3_inverse(transformed_image)
[M N ~] = size(transformed_image);
I_color = zeros(M/2,N/3*2,3);
for i = 1:(M/2)
    for j = 1:(N/3)*2
        current_j=floor((j+1)/2);
        new_block=transformed_image((2*i-1):(2*i) , (3*(current_j)-2):(3*current_j));
        I_color(i,j,1)=new_block(1,1);
        I_color(i,j,2)=new_block(1,2);
        I_color(i,j+1,3)=new_block(1,3);
        I_color(i,j,3) = new_block(2,1);
        I_color(i,j+1,1) = new_block(2,2);
        I_color(i,j+1,2) = new_block(2,3);
    end
end
original_image = I_color;

% original_image = uint8(I_color);
endfunction


function [transformed_image] = image_transformation_4x1(I_color)
[M N ~] = size(I_color);
transformed_image = zeros(4*M,N);
for i = 1:M
    for j = 1:N
        I=0.3*I_color(i,j,1)+0.59*I_color(i,j,2)+0.11*I_color(i,j,3);
        transformed_image((4*i-3):(4*i) , j)=[I I_color(i,j,1)  I_color(i,j,2) I_color(i,j,3)];
    end
end
% transformed_image = uint8(transformed_image);
endfunction


function [original_image] = image_transformation_4x1_inverse(transformed_image)
[M N ~] = size(transformed_image);
I_color = zeros(M/4,N,3);
for i = 1:M/4
    for j = 1:N
        I_color(i,j,1)=transformed_image((4*i-3):(4*i) , j)(2,1);
        I_color(i,j,2)=transformed_image((4*i-3):(4*i) , j)(3,1);
        I_color(i,j,3)=transformed_image((4*i-3):(4*i) , j)(4,1);
    end
end
% original_image = uint8(I_color);
original_image = I_color;

endfunction

function [transformed_image] = image_transformation_1x4(I_color)
[M N ~] = size(I_color);
transformed_image = zeros(M,4*N);
for i = 1:M
    for j = 1:N
        I=0.3*I_color(i,j,1)+0.59*I_color(i,j,2)+0.11*I_color(i,j,3);
        transformed_image(i,(4*j-3):(4*j))=[I I_color(i,j,1)  I_color(i,j,2) I_color(i,j,3)];
    end
end 
% transformed_image = uint8(transformed_image);
endfunction

function [original_image] = image_transformation_1x4_inverse(transformed_image)
[M N ~] = size(transformed_image);
I_color = zeros(M,N/4,3);
for i = 1:M
    for j = 1:N/4
        I_color(i,j,1)=transformed_image(i,(4*j-3):(4*j))(1,2);
        I_color(i,j,2)=transformed_image(i,(4*j-3):(4*j))(1,3);
        I_color(i,j,3)=transformed_image(i,(4*j-3):(4*j))(1,4);
    end
end
% original_image = uint8(I_color);
original_image = I_color;
endfunction


function [result_2x2 result_2x3 result_4x1 result_1x4] = image_transformation_all(I_color)  %all transformations
result_2x2 = image_transformation_2x2(I_color);
result_2x3 = image_transformation_2x3(I_color);
result_4x1 = image_transformation_4x1(I_color);
result_1x4 = image_transformation_1x4(I_color);
endfunction



% plot 5 images
function  plot_Transformation_models(I_color)
[result_2x2 result_2x3 result_4x1 result_1x4] = image_transformation_all(I_color);
figure;
subplot(2,3,1);
imshow(uint8(I_color));
title("Original");
subplot(2,3,2);
imshow(uint8(result_2x2));
title("2x2");
subplot(2,3,3);
imshow(uint8(result_2x3));
title("2x3");
subplot(2,3,4);
imshow(uint8(result_4x1));
title("4x1");
subplot(2,3,5);
imshow(uint8(result_1x4));
title("1x4");
endfunction


function result_img = alpha_root_enhancement(input_img, alpha_value=0.5)
    img_freq = fft2(input_img);
    img_angles = angle(img_freq);
    img_magnitude = abs(img_freq);
    alpha_root=(img_magnitude.^alpha_value).*(e.^(1i*img_angles));
    result_img = abs(ifft2(alpha_root));
    result_img = uint8(result_img);
endfunction

function [alpha_root_2x2 alpha_root_2x3 alpha_root_4x1 alpha_root_1x4] = alpha_root_enhancement_all(I_color, alpha_value=0.5)
    [result_2x2 result_2x3 result_4x1 result_1x4] = image_transformation_all(I_color);

    alpha_root_2x2_result = alpha_root_enhancement(result_2x2, alpha_value);
    alpha_root_2x2 = image_transformation_2x2_inverse(alpha_root_2x2_result);

    alpha_root_2x3_result = alpha_root_enhancement(result_2x3, alpha_value);
    alpha_root_2x3 = image_transformation_2x3_inverse(alpha_root_2x3_result);

    alpha_root_4x1_result = alpha_root_enhancement(result_4x1, alpha_value);
    alpha_root_4x1 = image_transformation_4x1_inverse(alpha_root_4x1_result);

    alpha_root_1x4_result = alpha_root_enhancement(result_1x4, alpha_value);
    alpha_root_1x4 = image_transformation_1x4_inverse(alpha_root_1x4_result);
endfunction



function  check_transformations()
    % check transformations
    input_img_test = zeros(5,5,3);
    input_img_test(:,:,1) = reshape(1:25,[5 5]);
    input_img_test(:,:,2) = reshape(26:26+24,[5 5]);
    input_img_test(:,:,3) = reshape(26+25:26+49,[5 5]);
    [M,N,~] = size(input_img_test);
    input_img_test = input_img_test(M-mod(M,2):M,N-mod(N,2):N,:);
    % isequal(input_img_test,input_img_test_2)

    result_2x2 = image_transformation_2x2(input_img_test);
    result_2x2_inverse = image_transformation_2x2_inverse(result_2x2);
    disp("2x2");
    disp(isequal(input_img_test,result_2x2_inverse));
    % isequal(input_img_test,result_2x2_inverse)

    result_2x3 = image_transformation_2x3(input_img_test);
    result_2x3_inverse = image_transformation_2x3_inverse(result_2x3);
    disp("2x3");
    disp(isequal(input_img_test,result_2x3_inverse));
    % isequal(input_img_test,result_2x3_inverse)

    result_4x1 = image_transformation_4x1(input_img_test);
    result_4x1_inverse = image_transformation_4x1_inverse(result_4x1);
    % isequal(input_img_test,result_4x1_inverse)
    disp("4x1");
    disp(isequal(input_img_test,result_4x1_inverse));

    result_1x4 = image_transformation_1x4(input_img_test);
    result_1x4_inverse = image_transformation_1x4_inverse(result_1x4);
    % isequal(input_img_test,result_1x4_inverse)
    disp("1x4");
    disp(isequal(input_img_test,result_1x4_inverse));
endfunction

function  plot_alpha_root_enhancement_models(I_color, alpha_value=0.5)
    [alpha_root_2x2 alpha_root_2x3 alpha_root_4x1 alpha_root_1x4] = alpha_root_enhancement_all(I_color, alpha_value);
    figure;
    subplot(2,3,1);

    imshow(uint8( I_color));
    title("Original");
    subplot(2,3,2);
    imshow(uint8(alpha_root_2x2));
    title("2x2");
    subplot(2,3,3);
    imshow(uint8(alpha_root_2x3));
    title("2x3");
    subplot(2,3,4);
    imshow(uint8(alpha_root_4x1));
    title("4x1");
    subplot(2,3,5);
    imshow(uint8(alpha_root_1x4));
    title("1x4");
endfunction

function ceme = calc_ceme(input_img, k)
    [M,N,~] = size(input_img);
    k1 = floor(M/k);
    k2 = floor(N/k);
    ceme_matrix = zeros(k1,k2);
    for i=1:k1
        for j=1:k2
            new_block = input_img(i*k-k+1:i*k,j*k-k+1:j*k,:)(:);
            block_max = max(new_block);
            block_min = min(new_block);
            if or(block_max==0, block_min==0)
                value=255;
            else
                value=block_max/block_min;
            end
            ceme_matrix(i,j) = 20*log10(value);
        end
    end
    ceme = sum(ceme_matrix(:))/(k1*k2);
endfunction

function eme = calc_eme(input_img, k)
    [M,N,~] = size(input_img);
    k1 = floor(M/k);
    k2 = floor(N/k);
    eme_matrix = zeros(k1,k2);
    for i=1:k1
        for j=1:k2
            new_block = input_img(i*k-k+1:i*k,j*k-k+1:j*k,:)(:);
            block_max = max(new_block);
            block_min = min(new_block);
            if or(block_max==0, block_min==0)
                value=255;
            else
                value=block_max/block_min;
            end
            eme_matrix(i,j) = 20*log10(value);
        end
    end
    eme = sum(eme_matrix(:))/(k1*k2);
endfunction

function calc_all_alpha_root(input_img, alpha_value=0.5, k=4)
    [img_t_2x2 img_t_2x3 img_t_4x1 img_t_1x4] = image_transformation_all(input_img);
    ceme_original = calc_ceme(input_img, k);

    alpha_root_2x2_img_t = alpha_root_enhancement(img_t_2x2, alpha_value);
    alpha_root_2x2_result = image_transformation_2x2_inverse(alpha_root_2x2_img_t);
    eme_original_2x2 = calc_eme(img_t_2x2, k);
    eme_alpha_root_2x2 = calc_eme(alpha_root_2x2_img_t, k);
    ceme_2x2 = calc_ceme(alpha_root_2x2_result, k);


    alpha_root_2x3_img_t = alpha_root_enhancement(img_t_2x3, alpha_value);
    alpha_root_2x3_result = image_transformation_2x3_inverse(alpha_root_2x3_img_t);
    eme_original_2x3 = calc_eme(img_t_2x3, k);
    eme_alpha_root_2x3 = calc_eme(alpha_root_2x3_img_t, k);
    ceme_2x3 = calc_ceme(alpha_root_2x3_result, k);


    alpha_root_4x1_img_t = alpha_root_enhancement(img_t_4x1, alpha_value);
    alpha_root_4x1_result = image_transformation_4x1_inverse(alpha_root_4x1_img_t);
    eme_original_4x1 = calc_eme(img_t_4x1, k);
    eme_alpha_root_4x1 = calc_eme(alpha_root_4x1_img_t, k);
    ceme_4x1 = calc_ceme(alpha_root_4x1_result, k);

    alpha_root_1x4_img_t = alpha_root_enhancement(img_t_1x4, alpha_value);
    alpha_root_1x4_result = image_transformation_1x4_inverse(alpha_root_1x4_img_t);
    eme_original_1x4 = calc_eme(img_t_1x4, k);
    eme_alpha_root_1x4 = calc_eme(alpha_root_1x4_img_t, k);
    ceme_1x4 = calc_ceme(alpha_root_1x4_result, k);

    printf("################ Alpha root enhancement ################\n");
    % formated print
    printf("CEME:\n");
    printf("orig: %.2f\n", ceme_original);
    printf("2x2:  %.2f\n", ceme_2x2);
    printf("2x3:  %.2f\n", ceme_2x3);
    printf("4x1:  %.2f\n", ceme_4x1);
    printf("1x4:  %.2f\n", ceme_1x4);
    printf("\n");


    printf("EME:\n");
    printf("     orig   alpha_root\n");
    printf("2x2: %.2f   %.2f \n", eme_original_2x2, eme_alpha_root_2x2);
    printf("2x3: %.2f   %.2f \n", eme_original_2x3, eme_alpha_root_2x3);
    printf("4x1: %.2f   %.2f \n", eme_original_4x1, eme_alpha_root_4x1);
    printf("1x4: %.2f   %.2f \n", eme_original_1x4, eme_alpha_root_1x4);


    % plot results
    figure("name", "Final results Alpha root");
    subplot(2,3,1);
    imshow(uint8(input_img));
    title("original");
    subplot(2,3,2);
    imshow(uint8(alpha_root_2x2_result));
    title("2x2");
    subplot(2,3,3);
    imshow(uint8(alpha_root_2x3_result));
    title("2x3");
    subplot(2,3,4);
    imshow(uint8(alpha_root_4x1_result));
    title("4x1");
    subplot(2,3,5);
    imshow(uint8(alpha_root_1x4_result));
    title("1x4");

    figure("name", "Alpha root");
    subplot(2,4,1);
    imshow(uint8(img_t_2x2));
    title("2x2");
    subplot(2,4,2);
    imshow(uint8(img_t_2x3));
    title("2x3");
    subplot(2,4,3);
    imshow(uint8(img_t_4x1));
    title("4x1");
    subplot(2,4,4);
    imshow(uint8(img_t_1x4));
    title("1x4");
    subplot(2,4,5);
    imshow(uint8(alpha_root_2x2_img_t));
    title("2x2");
    subplot(2,4,6);
    imshow(uint8(alpha_root_2x3_img_t));
    title("2x3");
    subplot(2,4,7);
    imshow(uint8(alpha_root_4x1_img_t));
    title("4x1");
    subplot(2,4,8);
    imshow(uint8(alpha_root_1x4_img_t));
    title("1x4");
endfunction


function calc_all_histogram_equalization_enhancement(input_img, k=4)
    [img_t_2x2 img_t_2x3 img_t_4x1 img_t_1x4] = image_transformation_all(input_img);
    ceme_original = calc_ceme(input_img, k);

    histeq_2x2_img_t = histeq(uint8(img_t_2x2))*255;
    histeq_2x2_result = image_transformation_2x2_inverse(histeq_2x2_img_t);
    eme_original_2x2 = calc_eme(img_t_2x2, k);
    eme_histeq_2x2 = calc_eme(histeq_2x2_img_t, k);
    ceme_2x2 = calc_ceme(histeq_2x2_result, k);


    histeq_2x3_img_t = histeq(uint8( img_t_2x3))*255;
    histeq_2x3_result = image_transformation_2x3_inverse(histeq_2x3_img_t);
    eme_original_2x3 = calc_eme(img_t_2x3, k);
    eme_histeq_2x3 = calc_eme(histeq_2x3_img_t, k);
    ceme_2x3 = calc_ceme(histeq_2x3_result, k);


    histeq_4x1_img_t = histeq(uint8( img_t_4x1))*255;
    histeq_4x1_result = image_transformation_4x1_inverse(histeq_4x1_img_t);
    eme_original_4x1 = calc_eme(img_t_4x1, k);
    eme_histeq_4x1 = calc_eme(histeq_4x1_img_t, k);
    ceme_4x1 = calc_ceme(histeq_4x1_result, k);

    histeq_1x4_img_t = histeq(uint8( img_t_1x4))*255;
    histeq_1x4_result = image_transformation_1x4_inverse(histeq_1x4_img_t);
    eme_original_1x4 = calc_eme(img_t_1x4, k);
    eme_histeq_1x4 = calc_eme(histeq_1x4_img_t, k);
    ceme_1x4 = calc_ceme(histeq_1x4_result, k);

    printf("################ Histogram equalization enhancement ################\n");
    % formated print
    printf("CEME:\n");
    printf("orig: %.2f\n", ceme_original);
    printf("2x2:  %.2f\n", ceme_2x2);
    printf("2x3:  %.2f\n", ceme_2x3);
    printf("4x1:  %.2f\n", ceme_4x1);
    printf("1x4:  %.2f\n", ceme_1x4);
    printf("\n");


    printf("EME:\n");
    printf("     orig   histogram_equalization\n");
    printf("2x2: %.2f   %.2f \n", eme_original_2x2, eme_histeq_2x2);
    printf("2x3: %.2f   %.2f \n", eme_original_2x3, eme_histeq_2x3);
    printf("4x1: %.2f   %.2f \n", eme_original_4x1, eme_histeq_4x1);
    printf("1x4: %.2f   %.2f \n", eme_original_1x4, eme_histeq_1x4);


    % plot results
    figure("name", "Final results Histogram equalization");
    subplot(2,3,1);
    imshow(uint8(input_img));
    title("original");
    subplot(2,3,2);
    imshow(uint8(histeq_2x2_result));
    title("2x2");
    subplot(2,3,3);
    imshow(uint8(histeq_2x3_result));
    title("2x3");
    subplot(2,3,4);
    imshow(uint8(histeq_4x1_result));
    title("4x1");
    subplot(2,3,5);
    imshow(uint8(histeq_1x4_result));
    title("1x4");

    figure("name", "Histogram equalization");
    subplot(2,4,1);
    imshow(uint8(img_t_2x2));
    title("2x2");
    subplot(2,4,2);
    imshow(uint8(img_t_2x3));
    title("2x3");
    subplot(2,4,3);
    imshow(uint8(img_t_4x1));
    title("4x1");
    subplot(2,4,4);
    imshow(uint8(img_t_1x4));
    title("1x4");
    subplot(2,4,5);
    imshow(uint8(histeq_2x2_img_t));
    title("2x2");
    subplot(2,4,6);
    imshow(uint8(histeq_2x3_img_t));
    title("2x3");
    subplot(2,4,7);
    imshow(uint8(histeq_4x1_img_t));
    title("4x1");
    subplot(2,4,8);
    imshow(uint8(histeq_1x4_img_t));
    title("1x4");

endfunction



% I_color = imread("WingedFigure.jpg");
I_color = imread("input_color.png");

I_color = imresize(I_color, [400 400]);
alpha_value = 0.95;
calc_all_alpha_root(I_color, alpha_value=0.95, k=8);
calc_all_histogram_equalization_enhancement(I_color, k=8);
pause;




