import matplotlib.pyplot as plt
import numpy as np

input_points = np.loadtxt("input_points.txt", delimiter=',', dtype=np.int)
x_coords = []
output = []
y_coords = []

L = 4  # interpolation factor
T = 1  # period time
j = 0
i = 0

for i in range(0, len(input_points) - 1):
    x_coords.append(T * (i - 1))
    k = 0  # first point
    output.append(input_points[i])
    y_coords.append(((i - 1) * T + (k / L) * T))  # calculate the coordinates of the interpolated points
    print("Element ", j, ": ", input_points[i])
    j += 1
    k = 1  # second point
    element = np.math.floor(input_points[i + 1] / 4) + np.math.floor(input_points[i] / 2) + np.math.floor(input_points[i] / 4)
    output.append(element)
    y_coords.append(((i - 1) * T + (k / L) * T))  # calculate the coordinates of the interpolated points
    print("Element ", j, ": ", element)
    j += 1
    k = 2  # third point
    element = np.math.floor(input_points[i+1] / 2) + np.math.floor(input_points[i] / 2)
    output.append(element)
    y_coords.append(((i - 1) * T + (k / L) * T))  # calculate the coordinates of the interpolated points
    print("Element ", j, ": ", element)
    j += 1
    k = 3  # fourth point
    element = np.math.floor(input_points[i] / 4) + np.math.floor(input_points[i+1] / 4) + np.math.floor(input_points[i+1] / 2)
    output.append(element)
    y_coords.append(((i - 1) * T + (k / L) * T))  # calculate the coordinates of the interpolated points
    print("Element ", j, ": ", element)
    j += 1
x_coords.append(T*i)  # calculate the coordinates of the input points

plt.plot(x_coords, input_points, marker='o')
plt.plot(y_coords, output, marker='x')
plt.show()

outputFile = open("output.txt", 'w')
for i in range(0, len(output)):
    outputFile.write("Point:" + str(i+1) + '{:>10}  {:>10}'.format(str(output[i]), str('{0:016b}'.format(output[i]))) + "\n")
outputFile.close()