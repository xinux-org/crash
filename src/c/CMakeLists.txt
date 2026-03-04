cmake_minimum_required(VERSION 3.26)
project(cflake C)

set(CMAKE_C_STANDARD 23)

# include_directories(./include)

file(
  GLOB SOURCE CONFIGURE_DEPENDS
  "*.h"
  "*.c"
)

add_executable(cflake ${SOURCE})

set(CMAKE_BUILD_TYPE Debug)

install(TARGETS cflake DESTINATION bin)
