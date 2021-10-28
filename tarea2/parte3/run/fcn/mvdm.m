function median_value = mvdm(x, y, z)
  vector = [x, y, z];
  sorted_vector = sort(vector);
  if (vector(2) == 0)
    median_value = vector(3);
  elseif (vector(2) == 255)
    median_value = vector(1);
  else
    median_value = vector(2);
  endif
endfunction