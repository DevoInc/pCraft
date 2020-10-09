include_directories(AFTER ${CMAKE_CURRENT_SOURCE_DIR}/include/ ${ami-project_SOURCE_DIR}/lib/include/ ${CMAKE_CURRENT_BINARY_DIR} ${Python_INCLUDE_DIRS})

set(AMIPP_SOURCES
  ami.cpp
  action.cpp
  )

message("Python include dirs:${Python_INCLUDE_DIRS}")

add_library(pyami MODULE ${AMIPP_SOURCES})
target_link_libraries(pyami PRIVATE pybind11::module PUBLIC ${AMI_LIBRARY})
set_target_properties(pyami PROPERTIES PREFIX "${PYTHON_MODULE_PREFIX}"
                                       SUFFIX "${PYTHON_MODULE_EXTENSION}")

