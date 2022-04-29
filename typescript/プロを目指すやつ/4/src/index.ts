function repeat<T>(element: T, length: number): T[] {
  const result: T[] = [];
  for(let i = 0; i < length; i++) {
    result.push(element);
  }
  return result;
}

console.log(repeat<string>("a", 5));
console.log(repeat<number>(123, 2));


function repeat2<T>(element: T): T[] {
  return [element];
}

console.log(repeat2<string>("a", 5));
console.log(repeat<number>(123, 2));


function repeat2<T>(element: T): T[] {
  return [element];
}
