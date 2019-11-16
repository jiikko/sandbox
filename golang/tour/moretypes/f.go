package main

import (
	"fmt"
)

func add(fun func(int, int) int) int {
	return fun(1, 1)
}

func main() {
	f := func(x, y int) int {
		return x + y + 1
	}
	fmt.Println(add(f))
	fmt.Println("end")
}
