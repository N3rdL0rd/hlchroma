cmake_minimum_required(VERSION 3.10)

project(chroma)

set(HASHLINK_SRC ${CMAKE_SOURCE_DIR}/../hlmod-hl)

add_library(chroma SHARED src/hlchroma.cpp)

set_target_properties(chroma PROPERTIES SUFFIX ".hdll")

target_include_directories(chroma PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/Include"
    "${HASHLINK_SRC}/src"
)

find_library(HL_LIBRARY NAMES libhl PATHS "${HASHLINK_SRC}/build/bin")

if (HL_LIBRARY)
    target_link_libraries(chroma ${HL_LIBRARY})
else()
    message(WARNING "libhl.lib not found. Please build hlmod-hl project first.")
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
