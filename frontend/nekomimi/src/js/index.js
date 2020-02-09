export class Hello {
  constructor(name) {
    this.say = name;
    this.say();
  }

  say() {
    console.log(`Hello ${this.name} World!`);
  }
}

export default new Hello('Nekomimi');
