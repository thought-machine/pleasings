// Package main implements an OpenPGP-compatible signer for our releases.
// It's ultimately easier to have our own, given a solid upstream library for it,
// than managing cross-platform issues with gpg.
package main

import (
	"fmt"
	"os"

	"github.com/jessevdk/go-flags"

	"signing/release_signer/signer"
)

var opts struct {
	Out      string `short:"o" long:"output" env:"OUT" description:"Output filename (signature)" required:"true"`
	In       string `short:"i" long:"input" description:"Input file to sign" required:"true"`
	Key      string `short:"k" long:"key" description:"Private ASCII-armoured key file to sign with" required:"true"`
	User     string `short:"u" long:"user" default:"releases@please.build" description:"User to sign for"`
	Password string `short:"p" long:"password" env:"GPG_PASSWORD" required:"true" description:"Password to unlock keyring"`
}

func main() {
	if _, err := flags.Parse(&opts); err != nil {
		os.Exit(1)
	} else if err := signer.SignFile(opts.In, opts.Out, opts.Key, opts.User, opts.Password); err != nil {
		fmt.Fprintf(os.Stderr, "Signing failed: %s\n", err)
		os.Exit(1)
	}
}
