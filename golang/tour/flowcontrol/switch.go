package main

import (
	"fmt"
	"runtime"
)

func main() {
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
	case "linux":
		fmt.Println("linux")
	default:
		fmt.Printf("%s.", os)
	}
}
