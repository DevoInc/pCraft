enable_testing()

include_directories(AFTER ${AMI_INCLUDE_DIRS})

add_executable(simple simple.c)
target_link_libraries(simple ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(Simple simple)
