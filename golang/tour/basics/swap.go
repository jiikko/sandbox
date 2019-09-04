package main

import "fmt"

func swap(x string, y string) (string, string) {
	return y, x
}

func main() {
	a, b := swap("hello", "aaa")
	fmt.Println(a, b)
}
