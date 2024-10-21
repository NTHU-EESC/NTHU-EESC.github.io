import numpy as np
import matplotlib.pyplot as plt
import math
import matplotlib.animation as animation

A = float(input("輸入A: "))
k = float(input("輸入k: "))

t = np.linspace(0, 0.5 * math.pi, 400)

# constant
c1 = (A * k) / (2.0 * k - 2.0)
c2 = (A * k) / (2.0 * k + 2.0)
c = c1 - c2

x = A * np.sin(t)
term1 = (A ** (1.0 / k)) / 2.0
term2 = k / (1.0 - k)
term3 = (A - x) ** (1.0 - 1.0 / k)
term4 = (A ** (-1.0 / k)) / 2.0
term5 = k / (1.0 + k)
term6 = (A - x) ** (1.0 + 1.0 / k)
y = term1 * term2 * term3 + term4 * term5 * term6 + c



fig = plt.figure(figsize = (7, 6), dpi = 100)
ax = fig.gca()

line, = ax.plot(x,
				y,
				color = 'blue',
				linestyle = '-',
				linewidth = 3,
				label = 'A = ' + str(A))

dot, = ax.plot([],
			   [],
			   color = 'r',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

man, = ax.plot([],
			   [],
			   color = 'black',
			   marker = 'o',
			   markersize = 10,
			   markeredgecolor = 'black')

ax.set_xlabel('x', fontsize = 14)
ax.set_ylabel('y', fontsize = 14)

def update(i):
	dot.set_data(x[i], y[i])
	man.set_data(A, c * t[i] / (0.5 * math.pi))
	return dot, man,

def init():
	dot.set_data(x[0], y[0])
	man.set_data(A, 0)
	return dot, man,

plt.xlim(0, A * 1.05)
plt.ylim(0, c * 1.05)
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