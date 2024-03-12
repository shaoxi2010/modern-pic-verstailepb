cmake_minimum_required(VERSION 3.18)
project(pic)

# 获取工具链头文件目录
execute_process(
	COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/toolchaindeploy.py 
		${CMAKE_C_COMPILER} 
		${CMAKE_SOURCE_DIR}/include/compiler 
	TIMEOUT 5
)
# FLAGS 声明
include_directories(${CMAKE_SOURCE_DIR}/include/compiler)
include_directories(include)
add_compile_options(-ffreestanding -nolibc -nostdinc)
add_compile_options(-fPIC)
add_compile_options(-std=gnu99)

# 子模块
add_subdirectory(startup)
add_subdirectory(app)
add_subdirectory(driver)

# 生成可执行文件
add_executable(${PROJECT_NAME})
target_link_libraries(${PROJECT_NAME} PRIVATE ${TARGET_LIBS})
target_link_options(${PROJECT_NAME} PRIVATE -fPIE)
target_link_options(${PROJECT_NAME} PRIVATE -ffreestanding -nolibc -nostartfiles)
target_link_options(${PROJECT_NAME} PRIVATE -T ${CMAKE_SOURCE_DIR}/scripts/pie.ld)
target_link_options(${PROJECT_NAME} PRIVATE -Wl,-Map=${CMAKE_SOURCE_DIR}/${PROJECT_NAME}.map)
if (DEFINED EXTERNSYMBOL_PATH)
target_link_options(${PROJECT_NAME} PRIVATE -Wl,-R=${EXTERNSYMBOL_PATH})
endif()

# 生成二进制文件
add_custom_command(
    TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary ${CMAKE_BINARY_DIR}/${PROJECT_NAME} ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
    COMMENT "Make ${PROJECT_NAME} binary"
    VERBATIM
)
