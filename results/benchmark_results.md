# Benchmark done on a set of 4 images of different resolutions

<br>

##### Julia built in

```
memory estimate:  423.01 MiB
  allocs estimate:  1013
  --------------
  minimum time:     743.869 ms (19.57% GC)
  median time:      767.464 ms (19.33% GC)
  mean time:        778.136 ms (21.09% GC)
  maximum time:     822.283 ms (25.53% GC)
  --------------
  samples:          7
  evals/sample:     1

```

<br>

##### Julia Loop

```
memory estimate:  423.01 MiB
  allocs estimate:  1013
  --------------
  minimum time:     739.217 ms (19.92% GC)
  median time:      751.942 ms (19.56% GC)
  mean time:        754.306 ms (20.57% GC)
  maximum time:     797.480 ms (25.84% GC)
  --------------
  samples:          7
  evals/sample:     1

```

<br>

##### Python Loop

```
memory estimate:  336 bytes
  allocs estimate:  13
  --------------
  minimum time:     32.340 s (0.00% GC)
  median time:      32.340 s (0.00% GC)
  mean time:        32.340 s (0.00% GC)
  maximum time:     32.340 s (0.00% GC)
  --------------
  samples:          1
  evals/sample:     1

```

<br>

##### Python Numpy

```
memory estimate:  336 bytes
  allocs estimate:  13
  --------------
  minimum time:     70.608 ms (0.00% GC)
  median time:      72.054 ms (0.00% GC)
  mean time:        74.342 ms (0.00% GC)
  maximum time:     92.222 ms (0.00% GC)
  --------------
  samples:          68
  evals/sample:     1

```

<br>

##### Python Opencv

```
memory estimate:  336 bytes
  allocs estimate:  13
  --------------
  minimum time:     71.669 ms (0.00% GC)
  median time:      74.788 ms (0.00% GC)
  mean time:        75.002 ms (0.00% GC)
  maximum time:     84.304 ms (0.00% GC)
  --------------
  samples:          67
  evals/sample:     1

```