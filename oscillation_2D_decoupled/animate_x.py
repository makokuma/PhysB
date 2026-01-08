import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# --- データ読み込み ---
data = np.loadtxt("data/x.dat")

t = data[:, 0]

# Fortran 側の出力形式:
# t, rx(1..N), ry(1..N)
ncol = data.shape[1]
N = (ncol - 1) // 2

rx = data[:, 1:1+N]
ry = data[:, 1+N:1+2*N]

# --- 描画準備 ---
fig, ax = plt.subplots()
#ax.set_aspect("equal")

ax.set_xlabel("x")
ax.set_ylabel("y")

spring_line, = ax.plot([], [], "-", lw=2, color="k")
mass_points, = ax.plot([], [], "o", ms=6, color="k")

#ax.set_aspect(8.0)
#ax.set_xlim(np.min(rx) - 0.5, np.max(rx) + 0.5)
#ax.set_ylim(np.min(ry) - 0.5, np.max(ry) + 0.5)
#ax.set_ylim(-1.0, 1.0)

ax.set_aspect("equal", adjustable="box")

xmin = np.min(rx) - 0.5
xmax = np.max(rx) + 0.5
ymin = np.min(ry) - 1.5
ymax = np.max(ry) + 1.5

ax.set_xlim(xmin, xmax)
ax.set_ylim(ymin, ymax)


# --- 初期化 ---
def init():
    spring_line.set_data(rx[0], ry[0])
    mass_points.set_data(rx[0], ry[0])
    return spring_line, mass_points

# --- 更新 ---
def update(frame):
    spring_line.set_data(rx[frame], ry[frame])
    mass_points.set_data(rx[frame], ry[frame])
    ax.set_title(f"2D oscillation N={N}  t = {t[frame]:.3f}")
    return spring_line, mass_points

# --- アニメーション ---
dt_frame = t[1] - t[0]
speedup = 200.0

ani = FuncAnimation(
    fig,
    update,
    frames=len(t),
    init_func=init,
    interval=dt_frame * 1000/speedup,
    blit=False
)

ani.save("oscillation_2D.mp4", writer="ffmpeg", fps=200)

plt.show()

