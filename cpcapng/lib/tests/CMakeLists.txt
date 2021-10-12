enable_testing()

add_executable(writeall writeall.c)
target_link_libraries(writeall ${CPCAPNG_LIBRARY} ${CMAKE_DL_LIBS})
add_test(WriteAll writeall)

add_executable(read read.c)
target_link_libraries(read ${CPCAPNG_LIBRARY} ${CMAKE_DL_LIBS})
add_test(Read read)
