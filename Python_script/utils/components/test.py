# from Python_script.utils.SETTINGS import PARAMS
from SETTINGS import PARAMS
import os
import sys

# sys.path.insert(0, '../utils/')
path_insert = './Python_script/utils/'
sys.path.insert(0, path_insert)

# sys.path.insert(0, '../general/')
print(sys.path)
print(os.listdir(path_insert))

# print(PARAMS)
