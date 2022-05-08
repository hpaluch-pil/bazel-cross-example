# Bazel Cross-compile example

Example how to cross-compile C++ program
with Bazel and various toolchains.

These targets are supported:

1. Local x86_64 using system GCC
1. External Linaro/aarch64 toolchain in /opt (see below)
1. embedded Linux (elinux) aarch64 target from TensorFlow (TF)
1. embedded Linux (elinux) amrhf (32 bit ARM with Hardware Float) target from TensorFlow (TF)

## Setup

Tested OS: `openSUSE LEAP 15.3`/`x86_64`

You need to install at least packages:
```bash
sudo zypper in curl git-core gcc-c++ gcc
```
To run `aarch64` and `armhf` targets in QEMU emulator, install this package:
```bash
sudo zypper in qemu-linux-user
```

Now install Bazelisk:
```bash
mkdir -p ~/bin
curl -fL -o ~/bin/bazel https://github.com/bazelbuild/bazelisk/releases/download/v1.11.0/bazelisk-linux-amd64
chmod +x ~/bin/bazel
```
Ensure that you are using your Bazelisk (named as `bazel`):
```bash
which bazel

/home/$USER/bin/bazel
```

Now checkout this source:
```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/hpaluch-pil/bazel-cross-example.git
cd bazel-cross-example
```

Now verify Bazel version - must be 4.2.2 to match `.bazelversion`
in this project:
```bash
$ bazel --version

bazel 4.2.2
```

## 1. Building: `x86_64`

It is useful to verify that Bazel is working as expected:

Just run:
```bash
# to see available targets
bazel query ...
# build target...
bazel build '//:hello'
```
You can run this program invoking:
```bash
bazel run '//:hello'
```
Example output:
```
INFO: Analyzed target //:hello (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //:hello up-to-date:
  bazel-bin/hello
INFO: Elapsed time: 1.056s, Critical Path: 0.80s
INFO: 3 processes: 1 internal, 2 linux-sandbox.
INFO: Build completed successfully, 3 total actions
INFO: Build completed successfully, 3 total actions
Hello, x86_64 world!
```


## 2. Building: `aarch64` external Linaro

At first install Linaro aarch64 cross-compiler:
- download:
  - https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz
- unpack it under `/opt`
- rename unpacked directory - WARNING! Symlink will not work with Bazel
  (it will use canonical path)
  ```bash
  sudo mv /opt/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu \
    /opt/aarch64-linux-gnu
  ```
- so verify that you have path like:
  ```
  /opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc
  ```

And run:

```bash
bazel build --config=aarch64 '//:hello'
```

It should build aarch64 binary - you can verify it with command:
```bash
$ readelf -h bazel-bin/hello | fgrep Machine:

 Machine:                           AArch64
```

To run aarch64 binary under QEMU emulation you can try this:
- and run binary user QEMU USER:
  ```bash
  qemu-aarch64 -L /opt/aarch64-linux-gnu/aarch64-linux-gnu/libc \
     bazel-bin/hello
  ```
- shoud produce output:
  ```
  Hello, aarch64 world!
  ```

## 3. Building elinux_aarch64

Uses embedded Linux (elinux) aarch64 target from TF. To build this
target run script:

```bash
./build_elinux_aarch64.sh
```

To verify target architecture try:
```bash
$ readelf -h bazel-bin/hello | fgrep Machine:

  Machine:                           AArch64

$ readelf -d bazel-bin/hello | fgrep NEEDED

 0x0000000000000001 (NEEDED)             Shared library: [libstdc++.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x0000000000000001 (NEEDED)             Shared library: [ld-linux-aarch64.so.1]
```

To run `elinux_aarch64` binary under QEMU AArch64 emulator try:
```bash
./run_qemu_elinux_aarch64.sh
```

## 4. Building elinux_armhf

Uses embedded Linux (elinux) 32-bit ARM HF (hardware float) target from TF. To build this
target run script:

```bash
./build_elinux_armhf.sh
```

To verify target architecture try:
```bash
$ readelf -h bazel-bin/hello | fgrep Machine:

  Machine:                           ARM

$ readelf -d bazel-bin/hello | fgrep NEEDED

 0x00000001 (NEEDED)                     Shared library: [libstdc++.so.6]
 0x00000001 (NEEDED)                     Shared library: [libgcc_s.so.1]
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]
 0x00000001 (NEEDED)                     Shared library: [ld-linux-armhf.so.3]
```

To run `elinux_armhf` binary under QEMU ARM try:
```bash
./run_qemu_elinux_armhf.sh
```


# Resources
* TensorFlow - elinux toolchains come from this project:
  * https://github.com/tensorflow/tensorflow
* https://docs.bazel.build/versions/main/tutorial/cc-toolchain-config.html
* https://docs.bazel.build/versions/2.2.0/tutorial/cc-toolchain-config.html

