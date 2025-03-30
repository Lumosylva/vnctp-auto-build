# vnpy使用的vnctp封装
### 1. 环境配置

- Python>=3.10
- Visual Studio>=2017;
- pybind11
- cmake

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

将vnctpmd.pyd 和 vnctptd.pyd 复制出来， 和 thostmduserapi_se.dll thosttraderapi_se.dll 放在同一目录。

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

### getApiVersion函数

本项目中使用.cpp源文件和.h头文件：vnctpmd.h、vnctpmd.cpp、vnctptd.h、vnctptd.cpp文件

其中添加了getApiVersion函数，便于在Python中调用CTP API时可以调用获取API版本的函数

### 4. 生成vnctpmd和vnctptd存根

生成vnctpmd和vnctptd存根是为了在Python代码中导入vnctpmd和vnctptd模块时避免提醒未解析的引用错误，虽然提示这个错误不影响代码运行。

存根文件一般以.pyi结尾，具体情况可以进一步学习。

conda激活Python环境或者直接在pycharm项目中打开终端

```bash
activate python312
```

#### 安装工具

```bash
pip install pybind11-stubgen
```

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

![cungen](.\cungen.png)

#### QQ交流群：446042777(澄明期货研究)