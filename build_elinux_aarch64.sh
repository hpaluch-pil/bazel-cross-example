#!/bin/bash
set -euo pipefail
cd $(dirname $0)
set -x
bazel build --config=elinux_aarch64 '//:hello'
exit 0

