import cv2
import numpy as np
a=(cv2.imread('label.png'))
smallest = np.amin(a[:,:,2])
biggest = np.amax(a[:,:,2])
print(smallest)
print(biggest)