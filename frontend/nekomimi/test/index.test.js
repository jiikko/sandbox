import { Hello } from '../src/js/index';

const name = 'Jest';
let hello;

describe('Hello Class Test', () => {
  beforeEach(() => {
    hello = new Hello(name);
  });

  test('We can check if the name', () => {
    expect(hello.name).toBe(name);
  });

  test('should call() on say() method', () => {
    const spy = jest.spyOn(console, 'log');
    hello.say();

    expect(spy).toHaveBeenCalledWith(`Hello ${name} World!`);
    spy.mockReset();
    spy.mockRestore();
  })
})
