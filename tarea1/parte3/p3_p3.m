clear;
clc;
close all;
pkg load image;

function img_list = load_images_from_directory (filepath)
  img_list = [];
  files = glob(filepath);
  for i=1:numel(files)
    name = files{i};
    img_matrix = im2double(imread(name));
    img_columnvector=img_matrix(:);
    img_list = horzcat(img_list, img_columnvector);
  endfor
endfunction

function prom_face = calc_prom_face (img_list)
  [cols N] = size(img_list);
  prom_face = zeros(1,cols);
  for i=1:cols
    prom_face(i) = sum(img_list(i,:))/N;
  endfor
endfunction


function diff_matrix = calc_diff_matrix(img_list,prom_face )
  diff_matrix=[];
  img_list_T=img_list';
  [cols N] = size(img_list);
  for i=1:N
    diff_matrix = vertcat(diff_matrix, minus(img_list_T(i,:),prom_face ));
  endfor
  diff_matrix=diff_matrix';
endfunction

function [ Ur, X, r] = calc_Ur(diff_matrix)
  
  [U,S,V] =svd(diff_matrix);
  r_diff= rank(diff_matrix);
##  size(U)
  Ur=U(:,1:r_diff);
  
  diff_matrix_T=diff_matrix';
  [cols N] = size(diff_matrix);
  X=[];
  for i=1:N
    X = vertcat(X, (Ur'*diff_matrix_T(i,:)')');
  endfor
  X=X';
  r=r_diff;
endfunction

function [minval, idx] = compare_face(Ur, X, prom_face, new_face)
  [cols N] = size(X);
  W=Ur'*minus(new_face,prom_face');
  norm_W_X = [];
  for i=1:N
    norm_W_X = [norm_W_X; norm(W-X(:,i))'];
  endfor
  [minval, idx] = min(norm_W_X);
endfunction




img_list = load_images_from_directory('Caras/Database/*.png');
prom_face=calc_prom_face (img_list);
##imshow(reshape(prom_face,112,92));
imwrite(reshape(prom_face,112,92),"promface.png")
diff_matrix = calc_diff_matrix(img_list,prom_face);

tic
[ Ur, X, r] = calc_Ur(diff_matrix);
toc



new_faces_filepaths= ["Caras/Comparar/daniel_4.png";"Caras/Comparar/tavo_16.png";];
n_faces= size(new_faces_filepaths)(1);


for i = 1:n_faces
  
  
new_face =im2double(imread(strcat (new_faces_filepaths(i,:))))(:);

subplot(n_faces,2, i*2-1);
imshow(reshape(new_face,112,92))
title('Imagen de entrada');

[minval, idx] = compare_face(Ur, X, prom_face, new_face);

new_title=strcat('Imagen en base de datos ', " E=", num2str(minval));

subplot(n_faces,2,i*2);
imshow(reshape(img_list(:,idx),112,92))
title(new_title);


endfor

