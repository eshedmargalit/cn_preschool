import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def dft(x):
    """
    Computes the discrete Fourier transform for a given input x
    """

    # if not already float, convert to float
    x = np.asarray(x, dtype=float)

    # number of elements
    N = len(x)
    n = np.arange(N)

    # frequencies to sample
    k = n.reshape([N,1])

    # generate complex-valued sine wave
    s_wave = sin_3d(n, k,
            amplitude=1)

    # return dot prod of sine wave and signal
    return np.dot(s_wave,x)

def fft(x):
    """
    Fast version of DFT which exploits symmetry
    """
    x = np.asarray(x, dtype=float)
    N = x.shape[0]

    # if array is too small for this to be helpful, just do a dft
    cutoff = 64

    # arrays must be of size 2 ^ x, because recursive operation is going to split array
    # in half on each recursive step
    if N % 2 > 0:
        raise ValueError("Can only operate on arrays whose size is a power of 2")
    elif N < cutoff: #if starting size is too small, just run the dft code above
        return dft(x)
    else: # begin recursive fft-ing
        evens = fft(x[::2]) #recursively run transform on evens
        odds = fft(x[1::2]) #recursively run transform on odds

        s_wave = sin_3d(np.arange(N), 1,
            amplitude=1)
        return np.concatenate([evens + s_wave[:N/2] * odds,
            evens + s_wave[N/2:] * odds])

def sin_3d(x,freq,amplitude=1):
    """
    Returns the complex-valued output of Euler's formula:
        y = amplitude*exp(i*2*pi*freq*(x-pi/2))
    
    Inputs:
        x (np.ndarray): the input values from which to compute the function 
        freq (np.ndarray): the frequencies of the generated sine waves
        amplitude (float): factor by which to scale entire function

    Returns:
        y (np.ndarray): complex-valued sine for inputs in x and frequencies in k 
    """

    return amplitude * np.exp(-1j * 2 * np.pi * freq * x / len(x))
