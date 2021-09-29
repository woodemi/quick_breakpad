cmake_minimum_required(VERSION 3.10)
set(PROJECT_NAME "quick_breakpad")
project(${PROJECT_NAME} LANGUAGES CXX)

# This value is used when generating builds using this plugin, so it must
# not be changed
set(PLUGIN_NAME "quick_breakpad_plugin")

add_library(${PLUGIN_NAME} SHARED
  "quick_breakpad_plugin.cc"
)
apply_standard_settings(${PLUGIN_NAME})
set_target_properties(${PLUGIN_NAME} PROPERTIES
  CXX_VISIBILITY_PRESET hidden)

target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

execute_process(COMMAND arch COMMAND tr -d '\n' OUTPUT_VARIABLE ARCHITECTURE)
add_library(breakpad_client STATIC IMPORTED)
set_target_properties(breakpad_client PROPERTIES
  IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/breakpad/${ARCHITECTURE}/libbreakpad_client.a"
)

target_include_directories(${PLUGIN_NAME}
  INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include"
  PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/breakpad/include"
)

target_link_libraries(${PLUGIN_NAME} PRIVATE flutter PkgConfig::GTK breakpad_client)

# List of absolute paths to libraries that should be bundled with the plugin
set(quick_breakpad_bundled_libraries
  ""
  PARENT_SCOPE
)
