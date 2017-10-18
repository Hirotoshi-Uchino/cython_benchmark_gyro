# -*- coding: utf-8 -*-
cimport cython

# ============== condition =================
cdef int N = 100000
cdef int epoch = 100
cdef double dt = 0.001
cdef double m = 1.
cdef double e = -1.
cdef double c = 1.
cdef double bf0 = 1.
cdef double ef0 = 0.005
cdef double[3] bf = [0., 0., bf0]
cdef double[3] ef = [0., 0., ef0]
cdef double[3] res
cdef double[3] tmp
cdef double[3] rkfd_tmp
cdef double[4][3] k

# ===========================================

cdef double* rkfd(double *v):

    res[0] = e/m * (ef[0] + (v[1]*bf[2] - v[2]*bf[1]))
    res[1] = e/m * (ef[1] + (v[2]*bf[0] - v[0]*bf[2]))
    res[2] = e/m * (ef[2] + (v[0]*bf[1] - v[1]*bf[0]))

    return res

cdef double* rk4(double *v):
    cdef int i

    for i in range(3):
        tmp[i] = v[i]

    rkfd_tmp = rkfd(tmp)
    for i in range(3):
        k[0][i] = dt * rkfd_tmp[i]

# ===================================

    for i in range(3):
        tmp[i] = v[i] + 0.5 * k[0][i]
    
    rkfd_tmp = rkfd(tmp)

    for i in range(3):
        k[1][i] = dt * rkfd_tmp[i]
# ===================================

    for i in range(3):
        tmp[i] = v[i] + 0.5 * k[1][i]
    
    rkfd_tmp = rkfd(tmp)

    for i in range(3):
        k[2][i] = dt * rkfd_tmp[i]
# ===================================

    for i in range(3):
        tmp[i] = v[i] + 0.5 * k[2][i]
    
    rkfd_tmp = rkfd(tmp)

    for i in range(3):
        k[3][i] = dt * rkfd_tmp[i]

# ====================================

    for i in range(3):
        v[i] = v[i] + (k[0][i] + 2.*k[1][i] + 2.*k[2][i] + k[3][i])/6.

    return v


cdef loop(double *r, double *v):
    cdef int i
    cdef int j

    for i in range(N):
        v = rk4(v)

        for j in range(3):
            r[j] = r[j] + dt*v[j]

        # if ((i % epoch) == 0 ):
        #     print('Iter: ', i, r)

    # return r#, v


def main():
    cdef double[3] r = [1., 0., 0.]
    cdef double[3] v = [0., 1., 0.] # 初期速度

    loop(r, v)

    # print(r, v)
