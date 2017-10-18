# cython_benchmark_gyro
Cythonのベンチマークテスト用のプログラム群です。  
計算課題として、プラズマの運動方程式を差分化して、4次ルンゲクッタ法で逐次的に解く方法を用います。  
srcディレクトリ以下に、  
- cython/ 
- fortran/
- pure_python/  
ディレクトリがあります。各ディレクトリ以下の説明は以下のとおりです。  

fortran/以下は、比較用にFortran90で書かれたコード`gyro_motion.f90`があります。ご自分の環境でコンパイルして時間を測定してください。  
pure_python/以下は、純粋なPythonで書かれたコード`gyro_motion_pure_py.py`があります。Python3で実行して時間を測定してください。  
cython/以下に、cythonで書かれた以下の2つのコードがあります。  
- gyro_motion_cython_type.pyx (変数の型宣言のみのコード) 
- gyro_motion_cython_func.pyx (関数の引数・戻り値まで型宣言するコード)
となります。  
```
python setup.py build_ext --inplace
```
を実行することで、.pyx→.cへの変換、.cのコンパイルまで実行します(事前に、CythonのインストールとCコンパイラを準備してください)。  
最後に、cy_gyro_test.pyを実行して、2つのCythonで書かれたコードの時間が測定可能です。
