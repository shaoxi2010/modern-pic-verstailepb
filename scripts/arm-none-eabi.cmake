# Sample toolchain file for crossiling to ARM

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Specify the cross compiler
# The target triple needs to match the prefix of the binutils exactly
# (e.g. CMake looks for arm-none-eabi-ar)
set(CMAKE_TOOLCHAIN_PREFIX /opt/arm-gnu-toolchain-12.2.mpacbti-rel1-x86_64-arm-none-eabi/bin/)
set(CMAKE_C_COMPILER ${CMAKE_TOOLCHAIN_PREFIX}arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${CMAKE_TOOLCHAIN_PREFIX}arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER ${CMAKE_TOOLCHAIN_PREFIX}arm-none-eabi-gcc)
set(CMAKE_OBJCOPY ${CMAKE_TOOLCHAIN_PREFIX}arm-none-eabi-objcopy)

# Don't run the linker on compiler check
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Specify compiler flags
set(ARCH_FLAGS "-mcpu=arm926ej-s -mno-unaligned-access")
set(CMAKE_C_FLAGS "-Wall -std=gnu11 ${ARCH_FLAGS}" CACHE STRING "Common flags for C compiler")
set(CMAKE_CXX_FLAGS "-Wall -std=gnu++11 ${ARCH_FLAGS}" CACHE STRING "Common flags for C++ compiler")
set(CMAKE_ASM_FLAGS "-Wall ${ARCH_FLAGS} -x assembler-with-cpp -D__ASSEMBLY__" CACHE STRING "Common flags for assembler")
#set(CMAKE_EXE_LINKER_FLAGS "-nostartfiles -Wl,-Map,kernel.map,--gc-sections -fuse-linker-plugin -Wl,--use-blx --specs=nano.specs --specs=nosys.specs" CACHE STRING "")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -g")

# where is the target environment
# set(CMAKE_FIND_ROOT_PATH /path/to/target/rootfs)

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
