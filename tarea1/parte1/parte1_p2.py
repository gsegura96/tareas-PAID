import cv2
import matplotlib.pyplot as plt
import numpy as np

def mediana(im):
  img = im
  w = 1
  for i in range(w,im.shape[0]-w):
    for j in range(w,im.shape[1]-w):
      block = im[i-w:i+w+1,j-w:j+w+1]
      m = np.median(block)
      img[i][j] = int(m)
  return img

image = cv2.imread('imagen1.jpg')
plt.subplot(1,2,1)
plt.imshow(image, cmap='gray')
image= np.asarray(image)
filtered_image = mediana(image)
plt.subplot(1,2,2)
plt.imshow(filtered_image, cmap='gray')
plt.show()
