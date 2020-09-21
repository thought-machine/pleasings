subinclude("//js:yarn")

yarn_workspace_root(name = "workspace")

# This generates the third party build rules replacing the pleasings sub-repo paths with relative
sh_cmd(
    name = "generate",
    cmd = "cat js/yarn_workspace_example/yarn.lock | plz run //js/yarn_deps | sed 's+///pleasings//js+//js+g' > js/yarn_workspace_example/third_party/BUILD",
)