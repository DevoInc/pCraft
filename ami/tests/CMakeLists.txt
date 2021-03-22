include_directories(AFTER ${AMI_INCLUDE_DIRS})

enable_testing()

configure_file("amitest.sh.cmake" "amitest.sh")

set(AMITEST "${ami-project_BINARY_DIR}/tests/amitest.sh")

add_test(functions.ami ${AMITEST} functions.ami)
add_test(test-max.ami ${AMITEST} test-max.ami)
add_test(field-assignment.ami ${AMITEST} field-assignment.ami)
add_test(loop2-then-action.ami ${AMITEST} loop2-then-action.ami)
add_test(vars.ami ${AMITEST} vars.ami)
add_test(non-existingvar.ami ${AMITEST} non-existingvar.ami)
add_test(mixedvars.ami ${AMITEST} mixedvars.ami)
add_test(strings.ami ${AMITEST} strings.ami)
add_test(include.ami ${AMITEST} include.ami)
add_test(repeat-in-repeat.ami ${AMITEST} repeat-in-repeat.ami)
add_test(braces.ami ${AMITEST} braces.ami)

add_executable(aminewclose ami-new-close.c)
target_link_libraries(aminewclose ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(AmiNewClose aminewclose)

add_executable(amiitems ami-items.c)
target_link_libraries(amiitems ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(AmiItems amiitems)

add_executable(actionnewclose action-new-close.c)
target_link_libraries(actionnewclose ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(ActionNewClose actionnewclose)

add_executable(apivars api-variables.c)
target_link_libraries(apivars ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(API_Variables apivars)

add_executable(sleepcursor sleepcursor.c)
target_link_libraries(sleepcursor ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(Sleep_Cursor sleepcursor)

add_executable(csvarray csvarray.c)
target_link_libraries(csvarray ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(CSVarray csvarray)

add_executable(csvfields csvfields.c)
target_link_libraries(csvfields ${AMI_LIBRARY} ${CMAKE_DL_LIBS})
add_test(CSVfields csvfields)
