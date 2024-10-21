import numpy as np
import matplotlib.pyplot as plt
import math
import matplotlib.animation as animation

t = np.linspace(0, 0.5 * math.pi, 400)

A = [1.0, 2.0, 3.0]
k = 2.0
c = [0.0, 0.0, 0.0]
x = []
y = []

# constant
for i in range(3):
    c1 = (A[i] * k) / (2.0 * k - 2.0)
    c2 = (A[i] * k) / (2.0 * k + 2.0)
    c[i] = c1 - c2
    
for i in range(3):
	x.append(A[i] * np.sin(t))
	term1 = (A[i] ** (1.0 / k)) / 2.0
	term2 = k / (1.0 - k)
	term3 = (A[i] - x[i]) ** (1.0 - 1.0 / k)
	term4 = (A[i] ** (-1.0 / k)) / 2.0
	term5 = k / (1.0 + k)
	term6 = (A[i] - x[i]) ** (1.0 + 1.0 / k)
	y.append(term1 * term2 * term3 + term4 * term5 * term6 + c[i])



fig = plt.figure(figsize = (7, 6), dpi = 100)
ax = fig.gca()

line1, = ax.plot(x[0],
				y[0],
				color = 'red',
				linestyle = '-',
				linewidth = 3,
				label = 'A = 1')

dot1, = ax.plot([],
			   [],
			   color = 'r',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

man1, = ax.plot([],
			   [],
			   color = 'black',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

line2, = ax.plot(x[1],
				y[1],
				color = 'green',
				linestyle = '-',
				linewidth = 3,
				label = 'A = 2')

dot2, = ax.plot([],
			   [],
			   color = 'r',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

man2, = ax.plot([],
			   [],
			   color = 'black',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

line3, = ax.plot(x[2],
				y[2],
				color = 'blue',
				linestyle = '-',
				linewidth = 3,
				label = 'A = 3')

dot3, = ax.plot([],
			   [],
			   color = 'r',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

man3, = ax.plot([],
			   [],
			   color = 'black',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

ax.set_xlabel('x', fontsize = 14)
ax.set_ylabel('y', fontsize = 14)

def update(i):
	dot1.set_data(x[0][i], y[0][i])
	dot2.set_data(x[1][i], y[1][i])
	dot3.set_data(x[2][i], y[2][i])
	man1.set_data(A[0], c[0] * t[i] / (0.5 * math.pi))
	man2.set_data(A[1], c[1] * t[i] / (0.5 * math.pi))
	man3.set_data(A[2], c[2] * t[i] / (0.5 * math.pi))
	return dot1, dot2, dot3, man1, man2, man3,

def init():
	dot1.set_data(x[0][0], y[0][0])
	dot2.set_data(x[1][0], y[1][0])
	dot3.set_data(x[2][0], y[2][0])
	man1.set_data(A[0], 0)
	man2.set_data(A[1], 0)
	man3.set_data(A[2], 0)
	return dot1, dot2, dot3, man1, man2, man3,

plt.xlim(0, A[2] * 1.05)
plt.ylim(0, c[2] * 1.05)
plt.grid()
plt.xlabel('x')
plt.ylabel('y')
plt.title('Path of the dog')
plt.legend(
	loc = 'best',
	fontsize = 10,
	shadow = True,
	facecolor = '#ccc',
	edgecolor = '#000',
	title_fontsize = 20)


ani = animation.FuncAnimation(fig,
							  update,
							  frames = 400,
							  init_func = init,
							  interval = 5,
							  blit = True)
plt.show()