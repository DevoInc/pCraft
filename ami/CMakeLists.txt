cmake_minimum_required(VERSION 2.8)

project(ami-project)

SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ami-project_SOURCE_DIR}/cmake)

if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
message(FATAL_ERROR "CMake generation is not allowed within the source directory!
Remove the CMakeCache.txt file and try again from another folder, e.g.:

   rm CMakeCache.txt
   mkdir build
   cd build
   cmake ..
")
endif()

include(GNUInstallDirs)

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)
find_package(libcsv REQUIRED)

set(AMI_INCLUDE_DIRS "${ami-project_SOURCE_DIR}/lib/include/" "${ami-project_BINARY_DIR}/lib/include")

set(AMI_LIBRARY ami)
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
	set(AMI_LIBRARY "${ami-project_BINARY_DIR}/lib/libami.dylib")
endif()

add_definitions(-ggdb)

add_subdirectory(lib)
add_subdirectory(bin)
