#!/bin/bash
set -euo pipefail
cd $(dirname $0)
sysroot=$HOME/.cache/bazel/_bazel_$USER/3aaf2cccc47418fa115da8d2c6890ad2/external/aarch64_linux_toolchain/aarch64-linux-gnu/libc
[ -d "$sysroot" ] || {
	echo "ERROR: sysroot '$sysroot' is not directory" >&2
	exit 1
}
exe=bazel-bin/hello 
[ -x "$exe" ] || {
	echo "Not executable '$exe'. Did you run ./build_elinux_aarch64.sh?" >&2
	exit 1
}
m=$(readelf -h $exe | fgrep Machine | awk '{print $2}')
exp_m=AArch64
[[ $m = $exp_m ]] || {
	echo "Executable $exe has unexpected architecture: '$m' <> '$exp_m'" >&2
	exit 1
}
set -x
qemu-aarch64 -L $sysroot \
     bazel-bin/hello
exit 0

