# 指定 cmake 最低编译版本
CMAKE_MINIMUM_REQUIRED(VERSION 3.14)

PROJECT (vnctp-auto-build)

# 添加源文件列表
FILE(GLOB TD_SRC_LIST "${PROJECT_SOURCE_DIR}/src/vnctptd/*.cpp")
FILE(GLOB MD_SRC_LIST "${PROJECT_SOURCE_DIR}/src/vnctpmd/*.cpp")


# 添加python和pybind11路径
set(PYTHONPATH D:/ProgramFiles/miniconda3/envs/python312)
set(PYBINDPATH D:/ProgramFiles/miniconda3/envs/python312/Lib/site-packages/pybind11)


# 指定头文件目录
INCLUDE_DIRECTORIES(
    ${PROJECT_SOURCE_DIR}/include
    ${PROJECT_SOURCE_DIR}/src               # 添加src目录以包含vnctp.h
    ${PROJECT_SOURCE_DIR}/include/ctp       # 确保CTP头文件路径正确
)

# 附加python头文件
INCLUDE_DIRECTORIES(${PYTHONPATH}/include)
# 附加pybind11头文件
INCLUDE_DIRECTORIES(${PYBINDPATH}/include)

# 添加共享库搜索路径
LINK_DIRECTORIES(${PROJECT_SOURCE_DIR}/lib)
# 附加python共享库
LINK_DIRECTORIES(D:/ProgramFiles/miniconda3/envs/python312/libs)

# 指定输出动态库的目录位置
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/target)

# 指定生成动态库vnctpmd
ADD_LIBRARY(vnctpmd SHARED ${MD_SRC_LIST})
# 指定输出动态库扩展名
SET_TARGET_PROPERTIES(vnctpmd PROPERTIES SUFFIX ".pyd")
# 指定链接库
TARGET_LINK_LIBRARIES(vnctpmd thostmduserapi_se thosttraderapi_se)
# 添加宏定义以禁用strcpy警告
TARGET_COMPILE_DEFINITIONS(vnctpmd PRIVATE _CRT_SECURE_NO_WARNINGS)

# 指定生成动态库vnctptd
ADD_LIBRARY(vnctptd SHARED ${TD_SRC_LIST})
# 指定输出动态库扩展名
SET_TARGET_PROPERTIES(vnctptd PROPERTIES SUFFIX ".pyd")
# 指定链接库
TARGET_LINK_LIBRARIES(vnctptd thostmduserapi_se thosttraderapi_se)
# 添加宏定义以禁用strcpy警告
TARGET_COMPILE_DEFINITIONS(vnctptd PRIVATE _CRT_SECURE_NO_WARNINGS)
