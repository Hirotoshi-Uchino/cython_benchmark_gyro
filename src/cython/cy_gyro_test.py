# -*- coding: utf-8 -*-
import pyximport
pyximport.install()
import gyro_motion_cython_type as gm_type
import gyro_motion_cython_func as gm_func
import time


t1 = time.perf_counter()
gm_type.main()
t2 = time.perf_counter()
print(t2 - t1)

t1 = time.perf_counter()
gm_func.main()
t2 = time.perf_counter()
print(t2 - t1)
