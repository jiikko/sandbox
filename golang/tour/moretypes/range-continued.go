package main

import "fmt"

func main2() {
	pow := make([]int, 10)
	for i := range pow {
		pow[i] = i << uint(i)
	}
	for _, value := range pow {
		fmt.Printf("%d\n", value)
	}
}

func main() {
	pow := make([]int, 10)
	for i := range pow {
		pow[i] = i << uint(i)
	}

	for _, i := range pow {
		fmt.Println(i)
	}
}
