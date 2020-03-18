class Creature {
  name: string
  address: number

  constructor(name: string, address: number) {
    this.name = name
    this.address = address
  }
}

const creature = new Creature("hai", 3)
console.log(creature)
