/*
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

console.log(repeat2<string>("a"));
console.log(repeat2<number>(123));


function repeat3<T>(element: T): T[] {
  return [element];
}



function repeat4<T>(element: T): T[] {
  return [element];
}
console.log(repeat4(123));



function repeat5<T, Z>(element: T, zoo: Z): Array<T | Z> {
  return [element, zoo];
}
console.log(repeat5(123, "foo"));
*/
