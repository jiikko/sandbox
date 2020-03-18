function wait(duration) {
    return new Promise(function (resolve) {
        setTimeout(function () { return resolve("passed"); }, duration);
    });
}
wait(1000).then(function (res) { });
