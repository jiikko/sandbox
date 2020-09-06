const sleep = ms => new Promise(resolve => setTimeout(resolve, ms));

const greet = async() => {
  console.log('hai');

  try{
    await sleep(2000);
    console.log('hai1');
    console.log('good morning');
  } catch (err) {
    console.error('fooo', err);
  }
}

greet();
