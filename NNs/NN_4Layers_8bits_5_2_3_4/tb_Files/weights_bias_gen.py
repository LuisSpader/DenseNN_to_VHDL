import numpy as np
import random

BIT_WIDTH = 8
WEIGHTS_NUMBER = 34

weights = []
# random integer from 0 to 9
for i in range(0, WEIGHTS_NUMBER):
    weights.append(random.randint(0, 2**BIT_WIDTH))
# print(weights)
weights_l0 = weights[0:15]
weights_l1 = weights[15:24]
weights_l2 = weights[24:30]
weights_l3 = weights[30:]

weights_l0 = '\n'.join(map(str, (weights_l0)))
weights_l1 = '\n'.join(map(str, (weights_l1)))
weights_l2 = '\n'.join(map(str, (weights_l2)))
weights_l3 = '\n'.join(map(str, (weights_l3)))


# print(weights_l0)
# print(weights_l1)
# print(weights_l2)
# print(weights_l3)
text_list = [weights_l0, '-------', weights_l1,
             '-------', weights_l2, '-------', weights_l3]
# text_list can be an splitted text or a list of texts
final_string = '\n'.join(map(str, (text_list)))

with open('weights.txt', 'w') as f:
    f.write(final_string)
