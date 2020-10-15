BISON_TARGET(parse parse.y ${CMAKE_CURRENT_BINARY_DIR}/parse.c)
FLEX_TARGET(scan scan.l  ${CMAKE_CURRENT_BINARY_DIR}/scan.c)
ADD_FLEX_BISON_DEPENDENCY(scan parse)

include_directories(AFTER ${FLEX_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/include/ ${CMAKE_CURRENT_BINARY_DIR} ${LIBCSV_INCLUDE_DIR})

add_definitions(-g)

set(AMI_SOURCES
  action.c
  ami.c
  ast.c
  csvread.c
  flow.c
  nast.c
  tree.c  
)

message("Bison output: ${BISON_parse_OUTPUTS}")
message("Flex output: ${FLEX_scan_OUTPUTS}")

add_library(ami SHARED ${FLEX_scan_OUTPUTS} ${BISON_parse_OUTPUTS} ${AMI_SOURCES})
set_target_properties(ami PROPERTIES SOVERSION 1)
target_link_libraries(ami ${CMAKE_DL_LIBS} "-L/usr/local/opt/bison/lib" ${LIBCSV_LIBRARY})

add_subdirectory(tests)

