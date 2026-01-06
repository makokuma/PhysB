import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt("data/x.dat")
t = data[:, 0]
x = data[:, 1:]

# 最初と最後を比較
plt.figure()
plt.plot(x[0], label="t = {:.2f}".format(t[0]))
plt.plot(x[-1], label="t = {:.2f}".format(t[-1]))
plt.xlabel("i (oscillator index)")
plt.ylabel("x")
plt.legend()
plt.tight_layout()
plt.show()

