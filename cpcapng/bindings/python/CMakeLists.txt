include_directories(AFTER ${CPCAPNG_INCLUDE_DIRS} ${Python_INCLUDE_DIRS})


set(PYCAPNG_SRC
  pycapng.cpp
  )

pybind11_add_module(pycapng ${PYCAPNG_SRC})
target_link_libraries(pycapng PRIVATE ${CPCAPNG_LIBRARY})
