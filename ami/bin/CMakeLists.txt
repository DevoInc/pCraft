include_directories(AFTER ${AMI_INCLUDE_DIRS})

add_executable(amidebug amidebug.c)
target_link_libraries(amidebug ${AMI_LIBRARY} ${CMAKE_DL_LIBS})

add_executable(tree tree.c)
target_link_libraries(tree ${AMI_LIBRARY} ${CMAKE_DL_LIBS})

add_executable(ami2debug ami2debug.c)
target_link_libraries(ami2debug ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
