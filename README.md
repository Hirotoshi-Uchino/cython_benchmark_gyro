# cython_benchmark_gyro
Cythonのベンチマークテスト用のプログラム群です。  
計算課題として、プラズマの運動方程式を差分化して、4次ルンゲクッタ法で逐次的に解く方法を用います。  
srcディレクトリ以下に、  
- cython 
- fortran
- pure_python
ディレクトリがあります。各ディレクトリ以下の説明は以下のとおりです。  

fortran/以下は、比較用にfortran90で書かれたコードがあります。ご自分の環境でコンパイルして時間を測定してください。  
pure_python以下は、純粋なpythonで書かれたコードがあります。python3で実行して時間を測定してください。  
cython以下に、cythonで書かれた以下の2つのコードがあります。  
- gyro_motion_cython_type.pyx (変数の型宣言のみのコード) 
- gyro_motion_cython_func.pyx (関数の引数・戻り値まで型宣言するコード)
となります。
