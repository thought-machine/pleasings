subinclude("//js:yarn")


# This runs the lodash_version script as defined in the package.json. Lodash
# This can be used for more advanced tasks like building a webpack but this demonstrates how
# to use the yarn_script rule.
yarn_script(
    name = "install",
    srcs = ["index.js"],
    outs = ["version.txt"],
    script_name = "lodash_version",
    deps = ["//js/yarn_workspace_example/foo_lib"],
)
