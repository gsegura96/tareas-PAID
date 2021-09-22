filepath='Caras/grupo/*.png';
files = glob(filepath);

for i=1:numel(files)
    name = files{i};
    img_matrix = im2double(imread(name));
    img_matrix=img_matrix(:,:,1);
    imwrite(img_matrix,name);
  endfor