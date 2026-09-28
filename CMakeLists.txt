cmake_minimum_required(VERSION 3.29)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)
project(Neon C ASM Swift)

# --- SWIFT COMPILATION MODE
set(CMAKE_Swift_COMPILATION_MODE wholemodule)

# --- EXECUTABLE
add_executable(kernel)
target_include_directories(kernel PRIVATE include)

# --- SUBDIRECTORIES
add_subdirectory(src)

# --- COMPILER FLAGS
target_compile_options(kernel PRIVATE
  # C
  $<$<COMPILE_LANGUAGE:C>:
    -mcmodel=medany
    -fomit-frame-pointer
    -ffreestanding
  >
  $<$<COMPILE_LANGUAGE:C>:$<$<CONFIG:Debug>:-Og>>
  $<$<COMPILE_LANGUAGE:C>:$<$<CONFIG:Release>:-O3>>

  # Assembly
  $<$<COMPILE_LANGUAGE:ASM>:
    -Qunused-arguments
  >

  # Swift
  $<$<COMPILE_LANGUAGE:Swift>:
    -no-allocations
    -enable-experimental-feature Embedded
    -Xfrontend -disable-stack-protector
    -Xcc -mcmodel=medany
  >
  $<$<COMPILE_LANGUAGE:Swift>:$<$<CONFIG:Debug>:-Onone>>
  $<$<COMPILE_LANGUAGE:Swift>:$<$<CONFIG:Release>:-O>>
)

# --- LINK SETTINGS
set(LINKER_SCRIPT )
target_link_options(kernel PRIVATE
  -fuse-ld=lld
  -nostdlib
  -nostartfiles
  -nodefaultlibs
  "LINKER:-T,${CMAKE_CURRENT_SOURCE_DIR}/link/kernel-${CMAKE_SYSTEM_PROCESSOR}.ld"
)

set_target_properties(kernel PROPERTIES
  LINKER_LANGUAGE C
  LINK_DEPENDS "${LINKER_SCRIPT}"
)
