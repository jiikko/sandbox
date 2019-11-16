package main

import "fmt"

func main() {
	m := make(map[string]int)
	m["Ans"] = 42
	fmt.Println("The value:", m["Ans"])

	m["Ans"] = 48
	fmt.Println("The value:", m["Ans"])

	delete(m, "Ans")
	fmt.Println("The value:", m["Ans"])

	v, ok := m["Ans"]
	fmt.Println("The value", v, "Prenset?", ok)
}
