let some: any = "hai";
let strl: number = (<string>some).length
let strls: number = (some as string).length
console.log(strl)
console.log(strls)
