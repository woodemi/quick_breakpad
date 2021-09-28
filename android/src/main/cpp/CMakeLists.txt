cmake_minimum_required(VERSION 3.4.1)  # for example

set(PLUGIN_NAME "quick-breakpad")

add_library(breakpad_client STATIC IMPORTED)
set_target_properties(breakpad_client PROPERTIES
        IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/${ANDROID_ABI}/libbreakpad_client.a
        )

add_library(${PLUGIN_NAME} SHARED
        "${CMAKE_CURRENT_SOURCE_DIR}/quick_breakpad.cpp"
        )

target_include_directories(${PLUGIN_NAME}
        PRIVATE # recursively with PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/breakpad"
        )

target_link_libraries(${PLUGIN_NAME} breakpad_client log)