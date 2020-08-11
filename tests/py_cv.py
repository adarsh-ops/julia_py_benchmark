import cv2
import numpy as np
import time


def adjust_brightness_cv(im_paths, factor):
    for im_path in im_paths:
        im_arr = cv2.imread(im_path)
        im_arr = cv2.addWeighted(im_arr, 1, np.zeros(im_arr.shape, im_arr.dtype), 0, factor)
        # im_arr = cv2.convertTo(float, im_arr, -1, 1, 45)