function wait(duration: number) {
  return new Promise(resolve => {
    setTimeout(() => resolve(`passed`), duration)
  })
}

wait(1000).then(res => {})
