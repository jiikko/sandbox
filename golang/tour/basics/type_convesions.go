package main

import (
	"fmt"
	"math"
)

func main() {
	var x, y int = 3, 4
	var f float64 = math.Sqrt(*x + y*y)
	var z uint = f
	fmt.Println(x, y, z)
}

// 別の型で宣言された変数には代入できない
// # command-line-arguments
// ./type_convesions.go:10:28: invalid indirect of x (type int)
// ./type_convesions.go:11:6: cannot use f (type float64) as type uint in assignment
