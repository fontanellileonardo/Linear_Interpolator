import numpy as np

input_points = np.loadtxt("input_points.txt", delimiter=',', dtype=np.int)
inputFile = open("input.txt", 'w')
inputFile.write("(")
for i in range(len(input_points)):
    element = '"' + '{0:016b}'.format(input_points[i]) + '"'
    if i != len(input_points) - 1:
        element += ", "
    inputFile.write(element)
inputFile.write(');')
inputFile.close()
