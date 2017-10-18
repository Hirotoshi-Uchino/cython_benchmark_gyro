from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [
    Extension("gyro_motion_cython_func", ["gyro_motion_cython_func.pyx"]),
    Extension("gyro_motion_cython_type", ["gyro_motion_cython_type.pyx"]),
]

setup(
    name = "Gyro Motion",
    cmdclass = { "build_ext" : build_ext},
    ext_modules = ext_modules,
)
