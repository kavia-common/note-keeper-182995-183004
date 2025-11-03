# Generated Flutter build rules for Linux.

set(FLUTTER_MANAGED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../build/linux/flutter")

# Include the Flutter-generated configuration.
include(${FLUTTER_MANAGED_DIR}/ephemeral/generated_config.cmake)

# The Flutter library and tool code.
set(FLUTTER_LIBRARY "${FLUTTER_MANAGED_DIR}/ephemeral/libflutter_linux_gtk.so")

add_library(flutter INTERFACE)
target_include_directories(flutter INTERFACE
  "${FLUTTER_MANAGED_DIR}/ephemeral"
)
target_link_libraries(flutter INTERFACE
  "${FLUTTER_LIBRARY}"
  gtk-3
  gobject-2.0
  glib-2.0
)

# Add the Flutter tool build rules.
add_custom_target(flutter_assemble DEPENDS
  "${FLUTTER_MANAGED_DIR}/ephemeral/flutter_linux"
  "${FLUTTER_MANAGED_DIR}/ephemeral/icudtl.dat"
  "${FLUTTER_MANAGED_DIR}/ephemeral/cpp_client_wrapper"
)
