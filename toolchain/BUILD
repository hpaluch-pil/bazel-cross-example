# name 'linaro_aarch` provides match for:
# --crosstool_top=//toolchain:linaro_aarch64
# from .bazelrc

load(":cc_toolchain_config.bzl", "cc_toolchain_config")

# defined in toolchain/cc_toolchain_config.bzl
cc_toolchain_config(name = "linaro_toolchain_config")

cc_toolchain_suite(
    name = "linaro_aarch64",
    toolchains = {
        "aarch64": ":linaro_aarch64_toolchain",
    },
)

filegroup(name = "empty")

cc_toolchain(
   name = "linaro_aarch64_toolchain",
   toolchain_identifier = "asmjs-toolchain",
   toolchain_config = ":linaro_toolchain_config",
   all_files = ":empty",
   compiler_files = ":empty",
   dwp_files = ":empty",
   linker_files = ":empty",
   objcopy_files = ":empty",
   strip_files = ":empty",
   supports_param_files = 0,
)
