ENGLISH | [中文](README.md)

# vnctp package used by vnpy

### 1. Environment configuration

- Windows
- Python>=3.10
- Visual Studio>=2017
- pybind11
- cmake
- vnpy CTP version: `v6.7.2_20230913`

Install cmake [Download address](https://cmake.org/download/ )

Configure environment variables for Python and cmake

Install pybind11

```bash
pip install pybind11
```

My own environment:

- Windows 11
- Python `3.12.9`
- Visual Studio 2022
- pybind11 `2.13.6`
- cmake `4.0.0`

### 2. Compile

Run the build.bat script to automatically compile. Compile vnctpmd.pyd and vnctptd.pyd under .\target\Release\, which are the market interface file and transaction interface file respectively.

``` bash
build.bat
```

### 3. Use

In the demo directory, copy vnctpmd.pyd and vnctptd.pyd, put them in the same directory as thostmduserapi_se.dll and thosttraderapi_se.dll, and create vnctp_demo.py

```python
from vnctpmd import MdApi
from vnctptd import TdApi

md = MdApi()
td = TdApi()
print(type(md))
print(type(td))
```

Output:

```
<class 'vnctpmd.MdApi'>
<class 'vnctptd.TdApi'>
```

Create get_api_version.py

```python
from vnctpmd import MdApi
from vnctptd import TdApi

md = MdApi()
td = TdApi()

print("MdApi Version:" + md.getApiVersion())
print("TdApi Version:" + td.getApiVersion())
```

Output:

```
MdApi Version:v6.7.2_20230913 10:48:10.4926
TdApi Version:v6.7.2_20230913 10:48:10.4926
```

### About getApiVersion

This project uses .cpp source files and .h header files: vnctpmd.h, vnctpmd.cpp, vnctptd.h, vnctptd.cpp are the files after adding the getApiVersion function, because there is no getApiVersion in the original file Function, in order to facilitate the function of getting API version when calling CTP API in Python sample code, getApiVersion function is added to these files.

### 4. Generate vnctpmd and vnctptd stubs

The purpose of generating vnctpmd and vnctptd stubs is to avoid prompting unresolved reference errors when importing vnctpmd and vnctptd modules in Python code, although prompting this error does not affect code operation.

Stub files generally end with .pyi, and the specific situation can be further studied.

The author used miniconda, and the Python virtual environment is named python312, so use conda to activate the Python environment or directly open the terminal in the PyCharm project to execute:

```bash
activate python312
```

#### Install tools

Install the pybind11-stubgen library

```bash
pip install pybind11-stubgen
```

pybind11-stubgen is a library that generates basic stubs from `.pyd` files, so that when users import modules, tools such as PyCharm and VSCode can automatically recognize these stubs and provide type hints. If you use the script function of build tools such as uv and poetry, you can add custom commands to run pybind11-stubgen through setup.py, and integrate the stub generation steps of `pybind11-stubgen` into the project's build process, and automate it through **`pyproject.toml`** and **`setup.py`** configuration.

#### Set the path where vnctpmd.pyd and vnctptd.pyd are located to the Python path

```bash
set PYTHONPATH=.
```

Or (`D:\Project\PycharmProjects\vnctp_demo\ctp` is the path to the directory where vnctpmd.pyd, vnctptd.pyd, thostmduserapi_se.dll, thosttraderapi_se.dll are located)

```
set PYTHONPATH=D:\Project\PycharmProjects\vnctp_demo\ctp
```

#### Generate vnctpmd and vnctptd stubs

```bash
pybind11-stubgen vnctpmd -o .
pybind11-stubgen vnctptd -o .
```

.pyi It is the suffix of the stub file. There is a difference between a stub file and one without a stub. The following figure shows that vnctpmd has no stub, while vnctptd has a stub in the code:

![cungen](cungen.png)

#### QQ Exchange Group: 446042777 (Chengming Futures Research)