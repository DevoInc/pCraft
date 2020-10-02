include_directories(AFTER ${AMI_INCLUDE_DIRS})

add_executable(amidebug amidebug.c)
target_link_libraries(amidebug ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
