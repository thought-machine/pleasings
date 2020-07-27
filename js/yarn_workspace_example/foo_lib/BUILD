subinclude("//js:yarn")

# Foo just exports a single function to get the lodash version it's using. This is used by bar_bin to demonstrate how
# node modules can transitively depend on each-others third_party deps
node_module(
    name = "foo_lib",
    srcs = ["index.js"],
    deps = ["//js/yarn_workspace_example/third_party:lodash"],
    visibility = ["//js/yarn_workspace_example/..."],
)