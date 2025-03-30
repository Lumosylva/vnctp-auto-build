# vnpy使用的vnctp封装
### 1. 环境配置

- Python>=3.10
- Visual Studio>=2017;
- pybind11
- cmake
- vnpy CTP版本：v6.7.2_20230913

安装cmake[下载地址](https://cmake.org/download/ )

Python和cmake配置好环境变量

安装pybind11

```bash
pip install pybind11
```

我自己的环境：

- Python 3.12.9
- Visual Studio 2022
- pybind11 2.13.6
- cmake 4.0.0

### 2. 编译

``` 
运行build.bat将会自动编译完成
```

### 3. 使用

见demo目录下，将vnctpmd.pyd 和 vnctptd.pyd 复制出来， 和 thostmduserapi_se.dll thosttraderapi_se.dll 放在同一目录，新建vnctp_demo.py

```python
from vnctpmd import MdApi
from vnctptd import TdApi


md = MdApi()
td = TdApi()
print(type(md))
print(type(td))
```

输出：

```
<class 'vnctpmd.MdApi'>
<class 'vnctptd.TdApi'>
```

新建get_api_version.py

```python
from vnctpmd import MdApi
from vnctptd import TdApi


md = MdApi()
td = TdApi()

print("MdApi Version:" + md.getApiVersion())
print("TdApi Version:" + td.getApiVersion())
```

输出：

```
MdApi Version:v6.7.2_20230913 10:48:10.4926
TdApi Version:v6.7.2_20230913 10:48:10.4926
```

### 关于getApiVersion

本项目中使用.cpp源文件和.h头文件：vnctpmd.h、vnctpmd.cpp、vnctptd.h、vnctptd.cpp为添加getApiVersion函数后的文件，因为在原始文件中没有getApiVersion函数，为了便于在Python示例代码中调用CTP API时可以调用获取API版本的函数，在这些文件中添加了getApiVersion函数。

### 4. 生成vnctpmd和vnctptd存根

生成vnctpmd和vnctptd存根是为了在Python代码中导入vnctpmd和vnctptd模块时避免提醒未解析的引用错误，虽然提示这个错误不影响代码运行。

存根文件一般以.pyi结尾，具体情况可以进一步学习。

作者使用了miniconda，所以用conda激活Python环境或者直接在pycharm项目中打开终端

```bash
activate python312
```

#### 安装工具

```bash
pip install pybind11-stubgen
```

pybind11-stubgen是一个将`.pyi` 文件生成基础存根的库，这样用户在导入模块时，PyCharm和VSCode等工具可以自动识别这些存根，提供类型提示。如果使用构建工具如uv、poetry的脚本功能，可以通过setup.py添加自定义命令来运行pybind11-stubgen，可以将 `pybind11-stubgen` 的存根生成步骤集成到项目的构建流程中，并通过 **`pyproject.toml`** 和 **`setup.py`**配置实现自动化。

#### 将vnctpmd.pyd和vnctptd.pyd所在路径设置到Python路径中

```bash
set PYTHONPATH=.
```

或者(ctp是vnctpmd.pyd、vnctptd.pyd、thostmduserapi_se.dll、thosttraderapi_se.dll所在的目录)

```
set PYTHONPATH=D:\Project\PycharmProjects\vnctp_demo\ctp
```

#### 生成vnctpmd和vnctptd存根

```bash
pybind11-stubgen vnctpmd -o .
pybind11-stubgen vnctptd -o .
```

有存根文件和没存根的区别：vnctpmd没有存根，vnctptd有存根，如图：

![cungen](https://github.com/Nilotica/vnctp-auto-build/blob/main/cungen.png)

#### QQ交流群：446042777(澄明期货研究)