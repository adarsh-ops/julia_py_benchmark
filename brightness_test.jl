using Images
using BenchmarkTools
using PyCall


# Julia implemention

function im2arr(im_path)
    im = load(im_path)
    im_float_arr = permutedims(channelview(im), (2, 3, 1))
    im_float_arr = Float64.(im_float_arr)
    return im_float_arr
end

function color_balance(im_arr, r, g, b)
    im_arr_cpy = copy(im_arr)

    im_arr_cpy[:, :, 1] = im_arr_cpy[:, :, 1] .+ r
    im_arr_cpy[:, :, 2] = im_arr_cpy[:, :, 2] .+ g
    im_arr_cpy[:, :, 3] = im_arr_cpy[:, :, 3] .+ b

    im_arr_cpy = clamp.(im_arr_cpy, 0, 255)
    return im_arr_cpy
end

function adjust_brightness(im_paths, factor)
    for im_path in im_paths
        im_arr = im2arr(im_path)
        color_balance(im_arr, factor, factor, factor)
    end
end


# Python numpy implemention

py"""
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

"""

adj_br_np_py = py"adjust_brightness"


# Python opencv implemention

py"""
import cv2
import numpy as np
import time


def adjust_brightness_cv(im_paths, factor):
    for im_path in im_paths:
        im_arr = cv2.imread(im_path)
        im_arr = cv2.addWeighted(im_arr, 1, np.zeros(im_arr.shape, im_arr.dtype), 0, factor)
"""

adj_br_cv_py = py"adjust_brightness_cv"


# Run benchmark

file_paths = ["images/001.jpg", "images/002.jpg", "images/003.jpg", "images/004.jpg"]

benchmark_dict = Dict()

j_bench = @benchmark adjust_brightness(file_paths, 50)
benchmark_dict["Julia"] = minimum(j_bench.times) / 1e6

py_np_bench = @benchmark $adj_br_np_py(file_paths, 50)
benchmark_dict["Python Numpy"] = minimum(py_np_bench.times) / 1e6

py_cv_bench = @benchmark $adj_br_cv_py(file_paths, 50)
benchmark_dict["Python Opencv"] = minimum(py_cv_bench.times) / 1e6


# unit in milliseconds
println(benchmark_dict)
