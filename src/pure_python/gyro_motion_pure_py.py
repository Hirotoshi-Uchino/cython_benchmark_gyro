#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import time

# ============== condition =================
N = 100000
epoch = 100
dt = 0.001
m = 1.
e = -1.
c = 1.
bf0 = 1.
k = [[0. for i in range(3)] for j in range(4)]

# ======= E//B用 ===========
ef0 = 0.005
bf = [0., 0., bf0]
ef = [0., 0., ef0]
res = [0., 0., 0.]
# f = open('../data/gyro_motion_EparaB_py.dat', 'w')

#  ========= ExB用 ==========
# ef0 = 0.1
# bf = [0., 0., bf0]
# ef = [0., ef0, 0.]
# f = open('../data/gyro_motion_EperpB_py.dat', 'w')

# ===========================================

def rkfd(v):

    res[0] = e/m*(ef[0] + (v[1]*bf[2] - v[2]*bf[1]))
    res[1] = e/m*(ef[1] + (v[2]*bf[0] - v[0]*bf[2]))
    res[2] = e/m*(ef[2] + (v[0]*bf[1] - v[1]*bf[0]))

    return res

def rk4(v):

    tmp = v[:]
    k[0][:] = [dt*var for var in rkfd(tmp)]

    tmp = v[:] + [0.5*var for var in k[0][:]]
    k[1][:] = [dt*var for var in rkfd(tmp)]

    tmp = v[:] + [0.5*var for var in k[1][:]]
    k[2][:] = [dt*var for var in rkfd(tmp)]

    tmp = v[:] + [0.5*var for var in k[2][:]]
    k[3][:] = [dt*var for var in rkfd(tmp)]

    for i in range(3):
        v[i] = v[i] + (k[0][i] + 2.*k[1][i] + 2.*k[2][i] + k[3][i])/6.


    return v


def loop(r, v):
    for i in range(N):
        v = rk4(v)

        for j in range(3):
            r[j] = r[j] + dt*v[j]

        # if ((i % epoch) == epoch-1):
        #     str_tmp = str(r[0]) + ', ' + str(r[1]) + ', ' + str(r[2]) + ', ' + str(v[0]) + ', ' + str(
        #         v[1]) + ', ' + str(v[2]) + os.linesep
        #     f.write(str_tmp)

                # if ((i % epoch) == 0 ):
        #     print('Iter: ', i, r)

    print(r, v)
    # return r, v

if __name__ == '__main__':
    # ===========================================

    r = [1., 0., 0.]
    v = [0., 1., 0.] # 初期速度


    # t1 = time.process_time()
    t1 = time.perf_counter()

    loop(r, v)


    # t2 = time.process_time()
    t2 = time.perf_counter()

    print(t2 - t1)

    # f.close()
