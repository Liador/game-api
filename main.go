package main

import (
	"fmt"
	"net/http"
	"log"
	"kalaxia-game-api/server"
)

func main() {
	if server.InitializeRsaVault() {
		fmt.Println("The RSA keys were generated")
	} else {
		fmt.Println("The RSA keys are already generated")
	}
  router := NewRouter()
  log.Fatal(http.ListenAndServe(":80", router))
}
