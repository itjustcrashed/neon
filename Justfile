# Builds a kernel from scratch.
all arch: clean (setup arch) build

# Creates build files for Ninja using CMake.
setup arch:
    cmake -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=toolchain/{{ arch }}.cmake

# Builds a kernel using Ninja.
build:
    ninja -C build

# Cleans generated artifacts.
clean:
    rm -rf build/
