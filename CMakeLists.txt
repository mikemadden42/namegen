cmake_minimum_required(VERSION 3.13)

project(namegen CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(NAMEGEN_SANITIZE "Build with address and undefined behavior sanitizers" OFF)

add_executable(namegen namegen.cc)

if (NOT MSVC)
  target_compile_options(namegen PRIVATE -Wall -Wextra -pedantic)
endif()

if (NAMEGEN_SANITIZE)
  set(SANITIZE_FLAGS -fsanitize=address,undefined -fno-sanitize-recover=all)
  target_compile_options(namegen PRIVATE ${SANITIZE_FLAGS} -fno-omit-frame-pointer)
  target_link_options(namegen PRIVATE ${SANITIZE_FLAGS})
endif()

enable_testing()
add_test(NAME namegen_output
  COMMAND ${CMAKE_COMMAND} -DNAMEGEN=$<TARGET_FILE:namegen>
          -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/run_namegen.cmake)
