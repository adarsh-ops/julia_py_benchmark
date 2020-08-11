from PIL import Image
import numpy as np
import time


def im2arr(im_path):
    im_arr = np.asarray(Image.open(im_path))
    return im_arr


def clamp(im_arr, min, max):
    im_arr[im_arr < min] = min
    im_arr[im_arr > max] = max
    return im_arr


def color_balance(im_arr, r, g, b):
    im_arr_cpy = im_arr.copy()

    im_arr_cpy[:, :, 0] = im_arr_cpy[:, :, 0] + r
    im_arr_cpy[:, :, 1] = im_arr_cpy[:, :, 1] + g
    im_arr_cpy[:, :, 2] = im_arr_cpy[:, :, 2] + b

    im_arr_cpy = clamp(im_arr_cpy, 0, 255)
    return im_arr_cpy


def adjust_brightness(im_paths, factor):
    for im_path in im_paths:
        im_arr = im2arr(im_path)
        im_arr = color_balance(im_arr, factor, factor, factor)