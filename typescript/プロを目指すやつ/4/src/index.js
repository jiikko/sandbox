"use strict";
const message = "hello";
console.log(message);

function repease<T>(element: T, length: number) T[] {
  const result: T[] = [];
  for(let i = 0; i < length; i++) {
    result.push(element);
  }
  return result;
}
