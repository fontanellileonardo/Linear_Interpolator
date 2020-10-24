import matplotlib.pyplot as plt
import numpy as np

input_points = np.loadtxt("input_points.txt", delimiter=',', dtype=np.int)
x_coords = []
output = []
y_coords = []

L = 4  # interpolation factor
T = 1  # period time
i = 0

for i in range(0, len(input_points) - 1):
    k = 0
    x_coords.append(T*(i-1))
    while k < L:
        u = k/L
        output.append(int((input_points[i + 1] - input_points[i]) * u + input_points[i])) # calculate the interpolation
        y_coords.append((i-1)*T+u*T)  # calculate the coordinates of the interpolated points
        k = k+1
x_coords.append(T*i)  # calculate the coordinates of the input points

plt.plot(x_coords, input_points, marker='o')
plt.plot(y_coords, output, marker='x')
plt.show()

outputFile = open("output.txt", 'w')
for i in range(0, len(output)):
    outputFile.write("Point:" + str(i+1) + '{:>10}  {:>10}'.format(str(output[i]), str('{0:016b}'.format(output[i]))) + "\n")
outputFile.close()
