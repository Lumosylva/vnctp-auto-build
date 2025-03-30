@echo off
REM 删除旧的构建目录和输出目录
if exist "build" (
    echo 正在删除旧构建目录 "build"...
    rmdir /s /q build
)
if exist "target" (
    echo 正在删除旧输出目录 "target"...
    rmdir /s /q target
)

REM 创建并进入新的构建目录
mkdir build
cd build

REM 生成CMake项目（依赖于Visual Studio）
echo 正在生成项目文件...
cmake ..
if %errorlevel% neq 0 (
    echo CMake生成失败！
    pause
    exit /b %errorlevel%
)

REM 编译项目（Release配置）
echo 正在编译Release版本...
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo 编译失败！
    pause
    exit /b %errorlevel%
)

echo 构建完成！输出文件位于 "../target/Release"。
pause