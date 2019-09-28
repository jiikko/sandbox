package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

func main() {

	var m = map[string]Vertex{
		"A": Vertex{
			1, -1,
		},
		"B": Vertex{
			2, -2,
		},
	}

	fmt.Println(m)
}
