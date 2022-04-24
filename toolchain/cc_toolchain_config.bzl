# toolchain/cc_toolchain_config.bzl:
# https://docs.bazel.build/versions/main/tutorial/cc-toolchain-config.html
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
     "feature",
     "flag_group",
     "flag_set",
     "tool_path")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc",
        ),
        tool_path(
            name = "ld",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-ld",
        ),
        tool_path(
            name = "ar",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-cpp",
        ),
        tool_path(
            name = "gcov",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-gcov",
        ),
        tool_path(
            name = "nm",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-nm",
        ),
        tool_path(
            name = "objdump",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/opt/aarch64-linux-gnu/bin/aarch64-linux-gnu-strip",
        ),
    ]

    features = [
           feature(
               name = "default_linker_flags",
               enabled = True,
               flag_sets = [
                   flag_set(
                       actions = all_link_actions,
                       flag_groups = ([
                           flag_group(
                               flags = [
                                   "-lstdc++",
                               ],
                           ),
                       ]),
                   ),
               ],
           ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "linaro-aarch64-toolchain",
        host_system_name = "x86_64-unknown-linux-gnu",
        target_system_name = "aarch64-linux-gnu",
        target_cpu = "aarch64",
        target_libc = "unknown",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = [
	    "/opt/aarch64-linux-gnu/aarch64-linux-gnu/libc/usr/include",
	    "/opt/aarch64-linux-gnu/aarch64-linux-gnu/include/c++",
	    "/opt/aarch64-linux-gnu/lib/gcc/aarch64-linux-gnu/7.2.1/include",
        ],
        features = features,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)

