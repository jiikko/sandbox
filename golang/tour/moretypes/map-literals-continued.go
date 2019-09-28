package main

import (
	"fmt"
	"reflect"
)

type Vertex struct {
	Lat, Long float64
}

type Vertex2 struct {
	a, Long float64
}

var m = map[string]Vertex2{
	"A": {1, 1},
	"B": {2, 2},
}

func main() {
	fmt.Println(reflect.TypeOf(m["A"]))
	fmt.Println(reflect.TypeOf(1))
}
