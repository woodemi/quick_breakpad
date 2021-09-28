cmake_minimum_required(VERSION 3.4.1)  # for example

set(PLUGIN_NAME "quick-breakpad-example")

add_library(${PLUGIN_NAME} SHARED
        "${CMAKE_CURRENT_SOURCE_DIR}/quick_breakpad_example.cpp"
        )

target_link_libraries(${PLUGIN_NAME} log)