using BenchmarkTools
using PyCall

include("tests/jl_builtin.jl")
include("tests/jl_loop.jl")


py"""
import sys
sys.path.insert(0, "./tests/")
"""

# Python control flow implemention
adj_br_loop_py = pyimport("py_loop")."adjust_brightness_loop"

# Python numpy implemention
adj_br_np_py = pyimport("py_np")."adjust_brightness"

# Python opencv implemention
adj_br_cv_py = pyimport("py_cv")."adjust_brightness_cv"



# Run benchmark
file_paths = ["images/001.jpg", "images/002.jpg", "images/003.jpg", "images/004.jpg"]

benchmark_dict = Dict()

j_bench = @benchmark adjust_brightness(file_paths, 50)
benchmark_dict["Julia"] = minimum(j_bench.times) / 1e6

j_loop_bench = @benchmark adjust_brightness_loop(file_paths, 50)
benchmark_dict["Julia loop"] = minimum(j_loop_bench.times) / 1e6

py_loop_bench = @benchmark $adj_br_loop_py(file_paths, 50)
benchmark_dict["Python Loop"] = minimum(py_loop_bench.times) / 1e6

py_np_bench = @benchmark $adj_br_np_py(file_paths, 50)
benchmark_dict["Python Numpy"] = minimum(py_np_bench.times) / 1e6

py_cv_bench = @benchmark $adj_br_cv_py(file_paths, 50)
benchmark_dict["Python Opencv"] = minimum(py_cv_bench.times) / 1e6


# Unit in milliseconds
println(benchmark_dict)
