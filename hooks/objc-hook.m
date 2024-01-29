#import <Foundation/Foundation.h>
#import <objc/runtime.h>

void hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass,
                SEL swizzledSelector) {
  Method originalMethod =
      class_getInstanceMethod(originalClass, originalSelector);
  Method swizzledMethod =
      class_getInstanceMethod(swizzledClass, swizzledSelector);
  if (originalMethod && swizzledMethod) {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

@interface NSObject (TargetClass)
+ (void)hookApp;
@end

@implementation NSObject (TargetClass)
- (void)hook_hello:(char)arg2 {
  // TODO ...
  // [self hook_hello:arg2] now hook_hello -> hello imp
}

+ (void)hookApp {
  hookMethod(objc_getClass("TargetClass"), @selector(hello:), [self class],
             @selector(hook_hello:));
}
@end

/*
 *  hook_with_method_setImplementation
 */
static IMP real_isEqualToString = NULL;
static BOOL custom_isEqualToString(id self, SEL _cmd, NSString *s) {
  NSLog(@"We are in the isEqualToString: hook. \\o/");
  NSLog(@"_cmd is: %@", NSStringFromSelector(_cmd));
  return ((BOOL(*)(id, SEL, NSString *))real_isEqualToString)(self, _cmd, s);
}

void hook_with_method_setImplementation() {
  real_isEqualToString = method_setImplementation(
      class_getInstanceMethod(NSClassFromString(@"__NSCFString"),
                              @selector(isEqualToString:)),
      (IMP)custom_isEqualToString);
}

int main(int argc, const char *argv[]) {
  hook_with_method_setImplementation();

  NSString *a = @"AAAA";
  NSLog(@"Equal: %hhd", [a isEqualToString:@"AAAA"]);
  NSLog(@"Equal: %hhd", [a isEqualToString:@"BBBB"]);
}