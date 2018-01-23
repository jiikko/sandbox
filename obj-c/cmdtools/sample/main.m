#import "anyClass.h"

int main(int argc, char *argv[]) {
    NSString *hoge = @"test";
    printf("String is %s\n", [hoge UTF8String]);
    printf("String is %s\n", [@"ほげぇ" UTF8String]);
    return 0;
}
