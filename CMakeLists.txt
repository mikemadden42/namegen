cmake_minimum_required(VERSION 3.10)

project(namegen CXX)

set (CMAKE_CXX_STANDARD 17)
if (NOT MSVC)
  set(CMAKE_CXX_FLAGS "-Wall -Wextra -pedantic")
endif()

add_executable(namegen namegen.cc)
