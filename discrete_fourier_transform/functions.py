import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def dft(x):
    """
    Computes the discrete Fourier transform for a given input x
    """

    N = len(x)

    amp = np.zeros([N-1])
    for k in xrange(N-1):
        s_wave = cos_3d(1, k, np.arange(N-1))
        dot = np.dot(s_wave, x[0:N-1])

        amp[k] = np.abs(dot) 


def sin_3d(amplitude,freq,x):
    """
    Returns the complex-valued output of Euler's formula:
        y = amplitude*exp(i*2*pi*freq*(x-pi/2))
    
    Inputs:
        amplitude (float): factor by which to scale entire function
        freq (float): the frequency of the generated sine wave
        x (np.ndarray): the input values from which to compute the function 

    Returns:
        y (np.ndarray): complex-valued sine for inputs in x 
    """

    i = np.complex(0,1)
    y = amplitude*np.exp(-i*2*np.pi*freq*((x-np.pi/2)))
    return y

def cos_3d(amplitude,freq,x):
    """
    Returns the complex-valued output of Euler's formula:
        y = amplitude*exp(i*2*pi*freq*x)
    
    Inputs:
        amplitude (float): factor by which to scale entire function
        freq (float): the frequency of the generated cosine wave
        x (np.ndarray): the input values from which to compute the function 

    Returns:
        y (np.ndarray): complex-valued cosine for inputs in x 
    """
    i = np.complex(0,1)
    y = amplitude*np.exp(-i*2*np.pi*freq*x)
    return y

