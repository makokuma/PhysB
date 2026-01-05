import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

def init():
    spring_line.set_data(pos, x[0])
    mass_points.set_data(pos, x[0])
    return spring_line, mass_points


def update(frame):
    y = x[frame]
    spring_line.set_data(pos, y)
    mass_points.set_data(pos, y)
    ax.set_title(f"animation of oscillation (N={N}), t = {t[frame]:.3f}")
    return spring_line, mass_points

data = np.loadtxt("data/x.dat")
t = data[:, 0]
x = data[:, 1:]

N = x.shape[1]
fig, ax = plt.subplots()
ax.set_title(f"animation of oscillation (N={N})")
#line, = ax.plot(range(N), x[0])
spring_line, = ax.plot([], [])   # バネ（線）
mass_points, = ax.plot([], [], 'o')  # 質点（丸）

mass_points.set_markersize(8)
mass_points.set_markerfacecolor("k")

mass_points.set_markeredgecolor("k")
mass_points.set_markeredgewidth(1.5)


spring_line.set_linewidth(2)
spring_line.set_color("k")

pos = np.arange(N)


#ax.set_aspect("equal")
ax.set_xlim(0, N-1)
ax.set_ylim(1.2*np.min(x), 1.2*np.max(x))
ax.set_xlabel("i")
ax.set_ylabel("x")
#ax.set_title(f'animation of oscillation N={N} {t}')

#def update(frame):
#    line.set_ydata(x[frame])
#    ax.set_title(f"t = {t[frame]:.3f}")
#    return line,

dt_frame = t[1] - t[0]

ani = FuncAnimation(fig, 
                    update, 
                    frames=len(t),
                    init_func=init,
                    interval=dt_frame * 1000,
                    blit=False
)

ani.save(
    "oscillation.gif",
    writer="pillow",
    fps=30
)


plt.show()

