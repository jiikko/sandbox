// type Filter = { <T>(array: T[], f: (item: T[]) => boolean): T[] }
// let filter2: Fileter = filter([1,2,3], n => false)
// filter([1,2,3], n => n > 2)

function a(x: string | number) {
  console.log(x)
}
 
a("BELTLOGGER");
a(9);


function b<T>(x: T) {
  console.log(x)
}
 
b("BELTLOGGER");
b(9);


function filter2<T>(array: T[], f: (item: T) => boolean) {
  let result = []
  for(let i = 0; i < array.length; i++) {
    let item = array[i]
    if(f(item)) {
      result.push(item)
    }
  }
  return result
}
console.log(filter2([1, 3, 5], _ => _ > 3))


function map<T>(array: T[], f: (item: T) => T) {
  let result = []
  for(let i = 0; i < array.length; i++) {
    let item = array[i]
    result.push(f(item))
  }
  return result
}
console.log(map([1, 3, 5], _ => (_ * 3)))

type MyEvent<T> = {
}

function is<T, U>(a: T, b: U | T) {
  console.log(`${a} === ${b} => ${a == b}`)
}

function isis<T, U>(a: T, b: U) {
  console.log(`${a} === ${b} => ${typeof(a) === typeof(b)}`)
}

is(1, "ji")
is(false, true)
is(false, false)
is(42, 42)
is(42, 43)
