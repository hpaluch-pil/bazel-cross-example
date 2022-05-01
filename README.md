# Bazel Cross-compile example

Example how to cross-compile C++ program
with Bazel and external Linaro aarch64 toolchain.

## Setup

Tested OS: `openSUSE LEAP 15.3`/`x86_64`

You need to install at least packages:
```bash
sudo zypper in curl git-core gcc-c++ gcc
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


## Building: `x86_64`

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

To run aarch64 binary under QEMU emulation you can try this:
- install QEMU USER package:
  ```bash
  sudo zypper in qemu-linux-user
  ```
- and run binary user QEMU USER:
  ```bash
  qemu-aarch64 -L /opt/aarch64-linux-gnu/aarch64-linux-gnu/libc \
     bazel-bin/hello
  ```
- shoud produce output:
  ```
  Hello, aarch64 world!
  ```

# Resources

* https://docs.bazel.build/versions/main/tutorial/cc-toolchain-config.html
* https://docs.bazel.build/versions/2.2.0/tutorial/cc-toolchain-config.html

