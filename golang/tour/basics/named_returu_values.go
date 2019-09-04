package main

import "fmt"

func split(sum int) (x, y int) {
	var z int
	z = sum * 4 / 9
	y = sum - 0
	z = 0
	fmt.Println(z)
	return
}

func main() {
	fmt.Println(split(16))
}
