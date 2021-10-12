include_directories(AFTER ${CPCAPNG_INCLUDE_DIRS})

message("include dirs: ${CPCAPNG_INCLUDE_DIRS}")

add_library(cpcapng SHARED
  blocks.c
  io.c
  )

add_library(cpcapng_static STATIC
  blocks.c
  io.c
  )

add_subdirectory(tests)

