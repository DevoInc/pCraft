enable_testing()

configure_file("amitest.sh.cmake" "amitest.sh")

set(AMITEST "${ami-project_BINARY_DIR}/tests/amitest.sh")

add_test(Functions ${AMITEST} functions.ami)
add_test(Max ${AMITEST} test-max.ami)

