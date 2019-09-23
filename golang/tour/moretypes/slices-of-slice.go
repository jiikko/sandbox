package main

import (
	"fmt"
	"strings"
)

func main() {
	// Create a tic-tag-toe board
	board := [][]string{
		[]string{"-", "-", "-"},
		[]string{"-", "-", "-"},
		[]string{"-", "-", "-"},
	}

	board[0][0] = "X"
	board[2][0] = "O"

	for i := 0; i < len(board); i++ {
		fmt.Printf("%s\n", strings.Join(board[i], " "))
	}
}
