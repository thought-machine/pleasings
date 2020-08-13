subinclude("//js:yarn")

yarn_script(
    name = "yarn_deps",
    srcs = ["index.js", "webpack.config.js"],
    outs = ["yarn_deps.js"],
    third_party_location = "js/yarn_deps/third_party",
    workspace = "", # this is set globally for the ../yarn_workspace_example but we're not in that workspace.
    deps = [
        "//js/yarn_deps/third_party:semver",
        "//js/yarn_deps/third_party:parse-yarn-lock",
        "//js/yarn_deps/third_party:webpack",
        "//js/yarn_deps/third_party:webpack-cli",
    ],
    binary = True,
)
