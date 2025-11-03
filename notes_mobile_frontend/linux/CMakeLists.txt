# Project-level CMake file for building the Flutter Linux desktop shell.

cmake_minimum_required(VERSION 3.10)
project(runner LANGUAGES CXX)

# Configure C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Define application name and binary
set(BINARY_NAME "notes_mobile_frontend")

# Use the Flutter-managed build rules for Linux.
add_subdirectory(flutter)

# Application
add_executable(${BINARY_NAME}
  "runner/main.cc"
  "runner/my_application.cc"
)

apply_standard_settings(${BINARY_NAME})

# Link Flutter and GTK
target_link_libraries(${BINARY_NAME} PRIVATE flutter)

# Define the resources
add_dependencies(${BINARY_NAME} flutter_assemble)

# Provided by the Flutter tool
target_include_directories(${BINARY_NAME} PRIVATE
  "${FLUTTER_BUILD_DIR}/linux/flutter/ephemeral"
)

# Bundle assets
flutter_install_assets(${BINARY_NAME})
