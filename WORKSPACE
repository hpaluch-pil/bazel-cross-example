# WORKSPACE - Bazel build tool workspace (empty)

# @local_config_embedded_arm - required by elinux in .bazelrc
load("//tensorflow/tools/toolchains/embedded/arm-linux:arm_linux_toolchain_configure.bzl", "arm_linux_toolchain_configure")
load("//third_party:repo.bzl", "tf_http_archive", "tf_mirror_urls")

# TFLite crossbuild toolchain for embeddeds Linux
arm_linux_toolchain_configure(
    name = "local_config_embedded_arm",
    build_file = "//tensorflow/tools/toolchains/embedded/arm-linux:template.BUILD",
    aarch64_repo = "../aarch64_linux_toolchain",
    armhf_repo = "../armhf_linux_toolchain",
)

tf_http_archive(
    name = "aarch64_linux_toolchain",
    build_file = "//tensorflow/tools/toolchains/embedded/arm-linux:aarch64-linux-toolchain.BUILD",
    sha256 = "8ce3e7688a47d8cd2d8e8323f147104ae1c8139520eca50ccf8a7fa933002731",
    strip_prefix = "gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu",
    urls = tf_mirror_urls("https://developer.arm.com/-/media/Files/downloads/gnu-a/8.3-2019.03/binrel/gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu.tar.xz"),
)

tf_http_archive(
    name = "armhf_linux_toolchain",
    build_file = "//tensorflow/tools/toolchains/embedded/arm-linux:armhf-linux-toolchain.BUILD",
    sha256 = "d4f6480ecaa99e977e3833cc8a8e1263f9eecd1ce2d022bb548a24c4f32670f5",
    strip_prefix = "gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf",
    urls = tf_mirror_urls("https://developer.arm.com/-/media/Files/downloads/gnu-a/8.3-2019.03/binrel/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf.tar.xz"),
)


