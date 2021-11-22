import cv2
import matplotlib.pyplot as plt
import numpy as np
import math
from matplotlib.patches import Circle

def detectCircles(img,threshold,region,radius = None):
    (M,N) = img.shape
    if radius == None:
        R_max = np.max((M,N))
        R_min = 3
    else:
        [R_max,R_min] = radius

    R = R_max - R_min

    #Inicializando los acumuladores de matrices.
    A = np.zeros((R_max,M+2*R_max,N+2*R_max))
    B = np.zeros((R_max,M+2*R_max,N+2*R_max))

    theta = np.arange(0,360)*np.pi/180
    edges = np.argwhere(img[:,:])                                               #Extracting all edge coordinates
    for val in range(R):
        r = R_min+val
        # Se crea la prueba de circulo
        bprint = np.zeros((2*(r+1),2*(r+1)))
        (m,n) = (r+1,r+1)                                                       #Finding out the center of the blueprint
        for angle in theta:
            x = int(np.round(r*np.cos(angle)))
            y = int(np.round(r*np.sin(angle)))
            #bprint[m+x,n+y] = 1 # <------------ SIN cambio aplicado
            bprint[m+x,n+y] = 1 * 1/(2*math.pi*r) # <------------ Cambio aplicado

        for x,y in edges:                                                       #For each edge coordinates
            # Iteracion de circulos sobre bordes y suma de acumulador
            X = [x-m+R_max,x+m+R_max]                                           #Computing the extreme X values
            Y= [y-n+R_max,y+n+R_max]                                            #Computing the extreme Y values
            A[r,X[0]:X[1],Y[0]:Y[1]] += bprint
        # A[r][A[r]<threshold*constant/r] = 0
        A[r][A[r]<threshold] = 0
    for r,x,y in np.argwhere(A):
        temp = A[r-region:r+region,x-region:x+region,y-region:y+region]
        try:
            p,a,b = np.unravel_index(np.argmax(temp),temp.shape)
        except:
            continue
        B[r+(p-region),x+(a-region),y+(b-region)] = 1

    return B[:,R_max:-R_max,R_max:-R_max]

def drawCircles(A, image):
    ax = plt.subplot(2,2,4);
    plt.title('Result');
    plt.imshow(image)
    circleCoordinates = np.argwhere(A)
    for r,x,y in circleCoordinates:
      ax.add_patch(Circle((y,x),r,color=(1,0,0),fill=False))

image = cv2.imread("imagen3.png")

edge_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
edge_image = cv2.GaussianBlur(image, (3, 3), 1)
edge_image = cv2.Canny(edge_image, 100, 300)


#imagen1
# res = detectCircles(edge_image,0.29,15,radius=[50,8])

#imagen2
# res = detectCircles(edge_image,0.3,15,radius=[50,10])

#imagen3
res = detectCircles(edge_image,0.5,15,radius=[50, 15])


plt.subplot(2,2,1);
plt.title('Original');
plt.imshow(image, cmap='gray');

plt.subplot(2,2,2);
plt.title('Edge');
plt.imshow(edge_image, cmap='gray');

drawCircles(res, image)
plt.show()


