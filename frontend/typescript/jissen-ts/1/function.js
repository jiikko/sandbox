// declare function get(amount: number, tax: number): string;
function get(amount, tax) {
    return amount * tax + "let a2: (string | number)[]";
}
// declare function get2(k?: number): 1 | ";";
function get2(k) {
    if (k) {
        return 1;
    }
    else {
        return ";";
    }
}
// declare function get3(score: 'A' | 'B'): 100 | 60;
function get3(score) {
    switch (score) {
        case 'A':
            return 100;
        case 'B':
            return 60;
    }
}
