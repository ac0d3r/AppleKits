#import <Foundation/Foundation.h>
#import "HookHelper.h"

@interface NSObject (hook)
+ (void) hookit;
@end

@implementation NSObject (hook)

+ (void) hookit
{
    NSLog(@"in hookit");
}
@end

static void __attribute__((constructor)) initialize(void) {
    [NSObject hookit];
}
