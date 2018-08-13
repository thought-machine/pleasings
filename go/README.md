Go rules
========

This contains a few extra rules for Go, specifically support for
[go-bindata](https://github.com/jteeuwen/go-bindata) which is a handy utility
for packaging arbitrary file data into a Go binary. It's often useful to
avoid needing to load additional files at runtime and avoiding potential
versioning issues. Please uses it during its build but the rules aren't
exposed as a builtin.

Note that while it's an excellent tool, it isn't ideal for packaging very
large files since it generates Go code which can become large (4x input file size)
and slow to compile. If you need to package large files then you may want
to look into the `c_embed_binary` builtin which is efficient for effectively
any file that you're willing to include into your binary - although it does
require cgo and is a little nontrivial to hook the two together.


go_yacc
-------

There is also a `go_yacc` rule here which we had once upon a time for generating
Yacc grammars. These days it is really only of historic interest since
`go tool yacc` was removed in Go 1.8.
