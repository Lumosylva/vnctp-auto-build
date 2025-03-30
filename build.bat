@echo off
REM ɾ���ɵĹ���Ŀ¼�����Ŀ¼
if exist "build" (
    echo ����ɾ���ɹ���Ŀ¼ "build"...
    rmdir /s /q build
)
if exist "target" (
    echo ����ɾ�������Ŀ¼ "target"...
    rmdir /s /q target
)

REM �����������µĹ���Ŀ¼
mkdir build
cd build

REM ����CMake��Ŀ��������Visual Studio��
echo ����������Ŀ�ļ�...
cmake ..
if %errorlevel% neq 0 (
    echo CMake����ʧ�ܣ�
    pause
    exit /b %errorlevel%
)

REM ������Ŀ��Release���ã�
echo ���ڱ���Release�汾...
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo ����ʧ�ܣ�
    pause
    exit /b %errorlevel%
)

echo ������ɣ�����ļ�λ�� "../target/Release"��
pause