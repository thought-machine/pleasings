for f in glob(["*.sh"]):
    sh_binary(
        name=splitext(f)[0],
        main = f,
        visibility = ["PUBLIC"],
    )
