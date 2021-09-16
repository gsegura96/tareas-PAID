import cv2
import matplotlib.pyplot as plt
import numpy as np
import math

def media(im):
  img = im
  w = 1
  for i in range(w,im.shape[0]-w):
    for j in range(w,im.shape[1]-w):
      if (im[i][j] == 0):
        block = im[i-w:i+w+1,j-w:j+w+1]
        m = np.mean(block,dtype=np.float32)
        img[i][j] = int(m)
  return img

def mediana(im):
  img = im
  w = 1
  for i in range(w,im.shape[0]-w):
    for j in range(w,im.shape[1]-w):
      if (im[i][j] == 0):
        block = im[i-w:i+w+1,j-w:j+w+1]
        m = np.median(block)
        img[i][j] = int(m)
  return img


def rotacion(A:np.array, angle):
  result = np.zeros(A.shape, dtype=np.uint8)
  M, N = A.shape[0],A.shape[1]
  xc= M//2
  yc= N//2
  a0 = np.cos(angle) 
  a1 = np.sin(angle)
  b0 = -np.sin(angle)
  b1 = np.cos(angle) 
  for i in range(M):
      for j in range(N):
          new_i=round(b0*(j - xc) + b1 * (i - yc) + yc)
          new_j=round(a0*(j - xc) + a1 * (i - yc) + xc)
          if (new_i>=0 and  new_i<M and new_j>=0 and  new_j<N ):
              result[new_i][new_j]=A[i][j]
  return result

image = cv2.imread('barbara.jpg',0)
plt.subplot(2,2,1)
plt.title('Imagen original')
plt.imshow(image, cmap='gray')

A = np.asarray(image)

B = rotacion(A,math.pi/4)
plt.subplot(2,2,2)
plt.title('Imagen rotada')
plt.imshow(B, cmap='gray', vmin=0, vmax=255)

C = media(B)
plt.subplot(2,2,3)
plt.title('Imagen rotada con media\n')
plt.imshow(C, cmap='gray')

D = mediana(B)
plt.subplot(2,2,4)
plt.title('Imagen rotada con mediana\n')
plt.imshow(D, cmap='gray')
plt.tight_layout()
plt.show()
