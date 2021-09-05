package main

import (
	"flag"
	"fmt"
	"os"
	"log"
)

var gitTag string
var (
	version = flag.Bool("version", false, "Show version number and quit")
)

func main() {
	flag.Parse()
	if *version {
		fmt.Println(gitTag)
		os.Exit(0)
	  }
	log.Printf("Scraping ")

}