# Bazel Cross-compile example

Example how to cross-compile C++ program
with Bazel and external Linaro aarch64 toolchain.

## Setup

Tested OS: `openSUSE LEAP 15.3`/`x86_64`

You need to install at least packages:
```bash
sudo zypper in git-core gcc-c++ gcc

```
Install these Bazel packages:
```bash
sudo zypper in bazel python-devel python-xml
```
This bazel version was tested:
```bash
$ bazel --version

bazel 3.4.1- (@non-git)
```


Now checkout this source:
```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/hpaluch-pil/bazel-cross-example.git
cd bazel-cross-example
```

## Building: `x86_64`

It is useful to verify that Bazel is working as expected:

Just run:
```bash
# to see available targets
bazel query ...
# build target...
bazel build '//:hello'
```

## Building: `aarch64`

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

# Resources

* https://docs.bazel.build/versions/main/tutorial/cc-toolchain-config.html
* https://docs.bazel.build/versions/2.2.0/tutorial/cc-toolchain-config.html

