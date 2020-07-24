subinclude("//js:yarn")

yarn_script(
    name = "install",
    srcs = ["index.js"],
    outs = ["index.js", "package.json", "node_modules"],
    script_name = "",
    third_party_location = "js/yarn_deps/third_party",
    deps = [
        "//js/yarn_deps/third_party:semver",
        "//js/yarn_deps/third_party:parse-yarn-lock",
    ]
)

sh_cmd(
    name = "run",
    data = [":install"],
    cmd = "node $(dirname $(out_location :run))/index.js",
)