cmake_minimum_required (VERSION 3.4)
project (cpcapng)


# add_definitions(-DDEBUG=1)


if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
message(FATAL_ERROR "CMake generation is not allowed within the source directory!
Remove the CMakeCache.txt file and try again from another folder, e.g.:

   rm CMakeCache.txt
   mkdir build
   cd build
   cmake ..
")
endif()

include_directories(AFTER ${cpcapng_SOURCE_DIR}/lib/include)

find_package(Python COMPONENTS Interpreter Development)
find_package(pybind11)
# find_path(WANDIO_INCLUDE_DIR NAMES wandio.h)
# find_library(WANDIO_LIBRARY NAMES wandio REQUIRED)
# include(FindPackageHandleStandardArgs)
# find_package_handle_standard_args(wandio "Could not find wandio library header and/or library ${DEFAULT_MSG}" WANDIO_INCLUDE_DIR WANDIO_LIBRARY)
# if(WANDIO_FOUND)
#   message("-- Found wandio: ${WANDIO_INCLUDE_DIR}" )
# endif()

set(CPCAPNG_INCLUDE_DIRS "${cpcapng_SOURCE_DIR}/lib/include/")
set(CPCAPNG_LIBRARY "${cpcapng_BINARY_DIR}/lib/libcpcapng.so")

add_definitions(-g)

add_subdirectory(lib)
add_subdirectory(bindings)

