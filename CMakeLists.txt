cmake_minimum_required(VERSION 2.8)

project(namegen CXX)

add_definitions(-Wall -O2 -std=c++14 -march=native)
add_executable(namegen namegen.cc)
