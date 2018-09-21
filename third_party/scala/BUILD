package(default_visibility = ["PUBLIC"])

subinclude("//scala")

maven_jar(
    name = "scala-library",
    id = "org.scala-lang:scala-library:2.12.6",
)

scala_jar(
    name = "scalatest",
    id = "org.scalatest:scalatest:3.2.0-SNAP10",
    deps = [
        ":scalactic",
    ],
)

scala_jar(
    name = "scalactic",
    id = "org.scalactic:scalactic:3.2.0-SNAP10",
)
