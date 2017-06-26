from __future__ import division

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
    N = 200
    x = np.linspace(0,50,N)
    y = np.sin(x) + np.random.normal(0,1,N)
    transform = dft(y)

    # get amplitudes 
    amp = (1/N) * np.abs(transform)

    # signal is real, so we keep the first half of freqs and double their amplitude
    amp = amp[0:int(N/2)] * 2


    # plot signal
    fig = plt.figure(figsize=(12,8))

    plt.subplot(211)
    plt.plot(x,y)
    plt.xlabel('Time')
    plt.ylabel('Signal')

    # plot spectrum
    plt.subplot(212)
    plt.plot(np.arange(0,N/2),amp)
    plt.xlabel('Frequency')
    plt.ylabel('Amplitude')

    plt.show()

if __name__ == '__main__':
    dft_plot()
