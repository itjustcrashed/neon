# The Neon Kernel

Neon is an experimental kernel that aims to be idiomatic of modern computers and do away with
traditionally used common-denominator abstractions.

The kernel is named after my favorite element.

## Supported Platforms

| Platform   | Support      | Notes             |
|------------|--------------|-------------------|
| AArch64    | 🕓 Planned   | Armv8-A           |
| RV64       | ✅ Supported | RV64GC            |
| AMD64      | ❌ Never     | Very, very legacy |

## Development

To build and develop the kernel, you'll need the following resources available:

* A decent computer with a **recent** version of macOS or Linux
* CMake, version **3.29 or later**
* LLVM tools, version **13 or later** (including Clang, LLD, LLVM, etc.)
* Swift tools, version **6.3 or later** (or `main-snapshot` from
  [swiftly](https://www.swift.org/install/))

> [!NOTE]
> It's probably also best that you use QEMU to virtualize/emulate your compiled kernels, since they
> can't be ran in user-space.
>
> Use Hypervisor.framework on macOS or KVM on Linux to drastically speed up your virtual machine if
> you're targeting the same CPU architecture as your host.

### Editors

Zed is the recommended editor for working on this project. These are some extensions that might be
useful to you:

* [**Assembly Language Server**](https://zed.dev/extensions/assembly)
* [**Linker Script**](https://zed.dev/extensions/linkerscript)
* [**NeoCMake**](https://zed.dev/extensions/neocmake)
* [**Swift**](https://zed.dev/extensions/swift)

Additionally, for any editor, a colorscheme with few unique colors is recommended simply due to the
ridiculous amount of complex, dense code that kernels require.

## Contribution and Redistribution

Contributions are welcome! This kernel is maintained by a single person (🥹), so please be nice.

The kernel is licensed under the **Apache License, Version 2.0** (see LICENSE for more details).
