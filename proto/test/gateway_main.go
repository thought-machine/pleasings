// Package main implements an example grpc-gateway server.
package main

import (
	"context"
	"fmt"
	"log"
	"net/http"

	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	"github.com/jessevdk/go-flags"
	"google.golang.org/grpc"

	gw "proto/test/kitten"
)

var opts struct {
	Port     int    `short:"p" long:"port" default:"8080" description:"Port to serve on"`
	Endpoint string `short:"e" long:"endpoint" default:"localhost:9090" description:"Endpoint to connect to"`
}

func run() error {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	log.Printf("Connecting client to %s...", opts.Endpoint)
	mux := runtime.NewServeMux()
	err := gw.RegisterPetShopHandlerFromEndpoint(ctx, mux, opts.Endpoint, []grpc.DialOption{grpc.WithInsecure()})
	if err != nil {
		return err
	}
	log.Printf("Serving on port %d...", opts.Port)
	return http.ListenAndServe(fmt.Sprintf(":%d", opts.Port), mux)
}

func main() {
	if _, err := flags.Parse(&opts); err != nil {
		log.Fatal(err)
	} else if err := run(); err != nil {
		log.Fatal(err)
	}
}
