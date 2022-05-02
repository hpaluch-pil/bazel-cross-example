#!/bin/bash
set -euo pipefail
cd $(dirname $0)
set -x
bazel build --config=elinux_armhf '//:hello'
exit 0

