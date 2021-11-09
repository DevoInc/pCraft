BISON_TARGET(parse parse.y ${CMAKE_CURRENT_BINARY_DIR}/parse.c)
FLEX_TARGET(scan scan.l  ${CMAKE_CURRENT_BINARY_DIR}/scan.c)
ADD_FLEX_BISON_DEPENDENCY(scan parse)

include_directories(AFTER ${CMAKE_CURRENT_SOURCE_DIR}/crypto/ ${CMAKE_CURRENT_SOURCE_DIR}/include/ ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/lib/include ${LIBCSV_INCLUDE_DIR} ${LibUUID_INCLUDE_DIRS} ${AVRO_INCLUDE_DIRS})

add_definitions(-g)

set(AMI_SOURCES
  action.c
  base64.c
  ami.c
  ast.c
  astnode.c
  cache.c
  csvread.c
  rc4.c
  strutil.c
  tree.c  
  variable.c

  crypto/md5.c
  crypto/rot-13.c
  crypto/sha1.c
  crypto/sha256.c

  ami2/ami2.c
  ami2/ast-node.c
)

message("Bison output: ${BISON_parse_OUTPUTS}")
message("Flex output: ${FLEX_scan_OUTPUTS}")

add_library(ami SHARED ${FLEX_scan_OUTPUTS} ${BISON_parse_OUTPUTS} ${AMI_SOURCES})
set_target_properties(ami PROPERTIES SOVERSION 1)
target_link_libraries(ami ${CMAKE_DL_LIBS} "-L/usr/local/opt/bison/lib" ${LIBCSV_LIBRARY} ${LibUUID_LIBRARIES} ${AVRO_LDFLAGS} "m")

#add_subdirectory(tests)

