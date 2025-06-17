import cv2
import numpy as np
import matplotlib.pyplot as plt
import math

"Import the image"
pic_color = cv2.imread("test.png")
row, column, RGB = pic_color.shape
pic_gray = np.zeros((row, column)).astype("int")
pic_size = row*column

"Obtain the gray value by weighting the value of RGB channels"
for y in range(0, row):
    for x in range(0, column):
        pic_gray[y, x] = 0.11 * pic_color[y, x, 0] + 0.59 * pic_color[y, x, 1] + 0.3 * pic_color[y, x, 2]
plt.figure()
plt.imshow(pic_gray, cmap='gray')
plt.title("Gray Image")

"Image Binarization"
# Use method OSTU to obtain the optimal threshold automatically
histogram = np.zeros(256, dtype=int)

for y in range(0, row):
    for x in range(0, column):
        histogram[int(pic_gray[y, x])] += 1
# Show the histogram of gray value distribution.
x = range(256)
plt.figure()
plt.bar(x, histogram, align='center')
plt.title('histogram')
plt.xlabel('gray value')
plt.ylabel('number of pixels')
plt.title("The Histogram of Gray Value Distribution")

# Calculate the maximum between-cluster variance and find the best appropriate threshold
v = 0
v_max = 0
threshold = 0
for thh in range(1, 255):
    w0_temp = u0_temp = w1_temp = u1_temp = 0
    for x in range(0, thh):
        w0_temp += histogram[x]
        u0_temp += x*histogram[x]
    for y in range(thh, 256):
        w1_temp += histogram[y]
        u1_temp += y*histogram[y]
    if w0_temp == 0:
        u0 = 0
    else:
        u0 = u0_temp/w0_temp
    if w1_temp == 0:
        u1 = 0
    else:
        u1 = u1_temp/w1_temp
    w0 = w0_temp/pic_size
    w1 = w1_temp/pic_size
    v = w0*w1*pow((u0-u1), 2)

    if v > v_max:
        v_max = v
        threshold = thh

# For connected component labeling
pic_label = np.zeros((row, column)).astype("uint8")

"Mark pixels with 0 and 255"
pic_binary = np.zeros((row, column)).astype("uint8")  # To store the binary value
pic_binary[:, :] = pic_gray[:, :]

for i in range(0, row):
    for j in range(0, column):
        if pic_binary[i, j] > threshold:
            pic_binary[i, j] = 0
            pic_label[i, j] = 0
        else:
            pic_binary[i, j] = 255
            pic_label[i, j] = 45
#  show the binary image
plt.figure()
plt.imshow(pic_binary, cmap='gray')
plt.title("Binary Image")

"Connected Component Labeling"
mark_start = 45
label = int(mark_start)
label_table = {}

# the first pass
for m in range(1, row):
    for n in range(1, column):
        if pic_label[m, n] == 0:
            continue
        else:
            if pic_label[m-1, n] == 0 and pic_label[m, n-1] == 0:  # left and up are background
                label += 1
                pic_label[m, n] = label
                label_table[label] = label  # create a new label
            elif pic_label[m-1, n] != 0 and pic_label[m, n-1] == 0:  # up is object
                pic_label[m, n] = pic_label[m-1, n]
            elif pic_label[m-1, n] == 0 and pic_label[m, n-1] != 0:  # left is background
                pic_label[m, n] = pic_label[m, n-1]
            elif pic_label[m-1, n] != 0 and pic_label[m, n-1] != 0:  # left and up are objects
                pic_label[m, n] = min(pic_label[m-1, n], pic_label[m, n-1])
                label_table[pic_label[m, n-1]] = label_table[pic_label[m-1, n]] = \
                    min(label_table[pic_label[m-1, n]], label_table[pic_label[m, n-1]])
# the second pass
label_obj = []
for i in range(0, row):
    for j in range(0, column):
        if pic_label[i, j] == 0:
            pic_label[i, j] = 255
        else:
            pic_label[i, j] = label_table[pic_label[i, j]]
            label_obj.append(pic_label[i, j])  # used to record the number of objects
label_obj = list(set(list(label_obj)))
num_obj = len(label_obj)

# mark different objects with different colors
pic_color = np.zeros((row, column, 3))
for i in range(row):
    for j in range(column):
        for k in range(3):
            if pic_label[i, j] == 255:
                pic_color[i, j, k] = 255
            else:
                pic_color[i, j, k] = pic_label[i, j]*(k+1)
plt.figure()
plt.imshow(pic_color.astype("uint8"))
plt.title("Segmented Image")

"Find and display the outline of the object"
b_box = [[] for i in range(num_obj)]
obj_box = np.zeros((num_obj, 4)).astype("int")  # to store the boundary points of each object(up,down,right and left)
pic_bound = np.zeros((row, column, 3)).astype("uint8")
pic_bound += 255
for i in range(1, row-1):
    for j in range(1, column-1):
        if pic_label[i, j] == 255:
            continue
        elif pic_label[i, j] != 255:
            sum = 0
            sum += pic_label[i-1, j]
            sum += pic_label[i+1, j]
            sum += pic_label[i, j-1]
            sum += pic_label[i, j+1]
            sum += pic_label[i-1, j-1]
            sum += pic_label[i+1, j+1]
            sum += pic_label[i-1, j+1]
            sum += pic_label[i+1, j-1]
            for k in range(3):
                if sum == pic_label[i, j]*8:
                    pic_bound[i, j, k] = 255  # judged as the inner part of image and set it as background
                else:
                    pic_bound[i, j, k] = pic_label[i, j]*(k+1)  # judged as boundary and keep its original color
                    for r in range(num_obj):
                        if pic_label[i, j] == label_obj[r]:
                            b_box[r].append([i, j])

def take(elem):
    return elem[1]
for i in range(num_obj):
    b_box[i].sort()  # the up boundary point
    obj_box[i, 0] = b_box[i][0][0]
    b_box[i].sort(reverse=True)  # the down boundary point
    obj_box[i, 1] = b_box[i][0][0]
    b_box[i].sort(key=take)  # the left boundary point
    obj_box[i, 2] = b_box[i][0][1]
    b_box[i].sort(key=take, reverse=True)  # the right boundary point
    obj_box[i, 3] = b_box[i][0][1]

print(b_box)  # print bounding box of the objects
print(obj_box)

plt.figure()
plt.imshow(pic_bound)
plt.title("Bounding Image")

"Calculate and show axis of the least second moment"
a = np.zeros(num_obj)
b = np.zeros(num_obj)
c = np.zeros(num_obj)
tan_xita_i = np.zeros(num_obj)
tan_xita_a = np.zeros(num_obj)
long = np.zeros(num_obj).astype("int")
short = np.zeros(num_obj).astype("int")
Xa = np.zeros(num_obj).astype("int")
Ya = np.zeros(num_obj).astype("int")

plt.figure()
plt.title("The Axis of Least Second Moment and the Best Appropriate Ellipse")
for i in range(num_obj):
    A = xita_i = xita_a = 0
    for m in range(obj_box[i, 0], obj_box[i, 1]+1):
        for n in range(obj_box[i, 2], obj_box[i, 3]+1):
            if pic_label[m, n] == label_obj[i]:
                A += pic_binary[m, n]
                Xa[i] += n*pic_binary[m, n]
                Ya[i] += m*pic_binary[m, n]
    Ya[i] = Ya[i]/A
    Xa[i] = Xa[i]/A

    # Draw the center of gravity (originally a point, expanded for clarity)
    pic_bound[Ya[i]-2:Ya[i]+2, Xa[i]-2:Xa[i]+2, :] = 0

    for m in range(obj_box[i, 0], obj_box[i, 1] + 1):
        for n in range(obj_box[i, 2], obj_box[i, 3] + 1):
            a[i] += pow((n-Xa[i]), 2)*pic_binary[m, n]
            b[i] += 2*(m-Ya[i])*(n-Xa[i])*pic_binary[m, n]
            c[i] += pow((m-Ya[i]), 2)*pic_binary[m, n]
    if (a[i] - c[i]) > 0:
        xita_i = math.atan(b[i]/(a[i] - c[i])) / 2
    if (a[i] - c[i]) < 0:
        xita_i = math.atan(b[i]/(a[i] - c[i])) / 2 + math.pi/2

    xita_e = xita_i*(180/math.pi)
    xita_a = xita_i+math.pi/2
    tan_xita_i[i] = math.tan(xita_i)
    tan_xita_a[i] = math.tan(xita_a)

    # 最小力矩轴
    x1_i = Xa[i]-((obj_box[i, 3]-obj_box[i, 2])/2)*abs(math.cos(xita_i))
    y1_i = (x1_i - Xa[i])*tan_xita_i[i] + Ya[i]
    x2_i = Xa[i]+((obj_box[i, 3]-obj_box[i, 2])/2)*abs(math.cos(xita_i))
    y2_i = (x2_i - Xa[i])*tan_xita_i[i] + Ya[i]
    plt.plot([x1_i, x2_i], [y1_i, y2_i], color='r')

    # 最大力矩轴
    x1_a = Xa[i]-((obj_box[i, 3]-obj_box[i, 2])/2)*abs(math.cos(xita_a))
    y1_a = (x1_a - Xa[i])*tan_xita_a[i] + Ya[i]
    x2_a = Xa[i]+((obj_box[i, 3]-obj_box[i, 2])/2)*abs(math.cos(xita_a))
    y2_a = (x2_a - Xa[i])*tan_xita_a[i] + Ya[i]
    plt.plot([x1_a, x2_a], [y1_a, y2_a], color='g')
    ax = plt.gca()  # Gets the current coordinate axis information
    ax.xaxis.set_ticks_position('top')  # move the X-axis up here

    xi = []
    xa = []
    xis1 = min((obj_box[i, 0]-Ya[i])/tan_xita_i[i]+Xa[i], (obj_box[i, 1]-Ya[i])/tan_xita_i[i]+Xa[i])
    xis2 = max((obj_box[i, 0]-Ya[i])/tan_xita_i[i]+Xa[i], (obj_box[i, 1]-Ya[i])/tan_xita_i[i]+Xa[i])
    xis = int(max(xis1, obj_box[i, 2]))
    xie = math.ceil(min(xis2, obj_box[i, 3]))  # Round up

    xas1 = (min((obj_box[i, 0]-Ya[i])/tan_xita_a[i]+Xa[i], (obj_box[i, 1]-Ya[i])/tan_xita_a[i]+Xa[i]))
    xas2 = (max((obj_box[i, 0]-Ya[i])/tan_xita_a[i]+Xa[i], (obj_box[i, 1]-Ya[i])/tan_xita_a[i]+Xa[i]))
    xas = int(max(xas1, obj_box[i, 2]))
    xae = math.ceil(min(xas2, obj_box[i, 3]))

    for p in range(xis, xie+1):
        yi = int((p - Xa[i])*tan_xita_i[i] + Ya[i])
        if pic_label[yi, p] == label_obj[i]:
            xi.append(p)
    xii = min(xi)
    xia = max(xi)

    ua = ha = 0
    ui = hi = 0
    da = di = 100
    for z in range(len(b_box[i])):
        if b_box[i][z][1] == xia:
            ua = b_box[i][z][0]
            ha = abs((xia-Xa[i])*math.sin(xita_i)-(ua-Ya[i])*math.cos(xita_i))
            if ha < da:
                yia = ua
                da = ha
        if b_box[i][z][1] == xii:
            ui = b_box[i][z][0]
            hi = abs((xii-Xa[i])*math.sin(xita_i)-(ui-Ya[i])*math.cos(xita_i))
            if hi < di:
                yii = ui
                di = hi
    pic_bound[yia - 1:yia + 1, xia - 1:xia + 1, :] = 0  # draw the bounding point
    pic_bound[yii - 1:yii + 1, xii - 1:xii + 1, :] = 0
    long[i] = int(pow(pow(xia-xii, 2)+pow(yia-yii, 2), 1/2)/2)

    for p in range(xas, xae+1):
        ya = int((p - Xa[i])*tan_xita_a[i] + Ya[i])
        if pic_label[ya, p] == label_obj[i]:
            xa.append(p)
    xai = min(xa)
    xaa = max(xa)

    ua = ha = 0
    ui = hi = 0
    da = di = 100
    for z in range(len(b_box[i])):
        if b_box[i][z][1] == xaa:
            ua = b_box[i][z][0]
            ha = abs((xaa-Xa[i])*math.sin(xita_a)-(ua-Ya[i])*math.cos(xita_a))
            if ha < da:
                yaa = ua
                da = ha
        if b_box[i][z][1] == xai:
            ui = b_box[i][z][0]
            hi = abs((xai-Xa[i])*math.sin(xita_a)-(ui-Ya[i])*math.cos(xita_a))
            if hi < di:
                yai = ui
                di = hi
    pic_bound[yaa-1:yaa+1, xaa-1:xaa+1, :] = 0
    pic_bound[yai-1:yai+1, xai-1:xai+1, :] = 0
    short[i] = int(pow(pow(xaa - xai, 2) + pow(yaa - yai, 2), 1 / 2)/2)

    cv2.ellipse(pic_bound, (Xa[i], Ya[i]), (long[i], short[i]), xita_e, 0, 360, (100, 100, 100), 1)  # draw the ellipse
plt.imshow(pic_bound)
plt.show()



