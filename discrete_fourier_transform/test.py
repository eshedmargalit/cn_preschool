import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

from functions import *

def sin_plot():
    amplitude = 1 
    freq = 1 
    n = 500
    x = np.linspace(0,5,n)

    y = sin_3d(amplitude,freq,x)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.plot(x,y.real,y.imag,color=[1,0,0])
    ax.set_xlabel('Real x')
    ax.set_ylabel('Real y')
    ax.set_zlabel('Imag y')
    plt.show()

def dft_plot():
    x = np.linspace(0,50,50)
    y = np.sin(x) + np.random.normal(0,1,50)
    dft(y)

if __name__ == '__main__':
    dft_plot()
