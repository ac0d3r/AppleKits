#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface HookHelper : NSObject

/* hook 实例方法
  @param originalClass 原类
  @param originalSelector 原实例方法
  @param swizzledClass 替换类
  @param swizzledSelector 替换实例方法
*/
void hookMethodWithSwizz(Class originalClass, SEL originalSelector,
                         Class swizzledClass, SEL swizzledSelector);

/* hook 类方法
  @param originalClass 原类
  @param originalSelector 原实例方法
  @param swizzledClass 替换类
  @param swizzledSelector 替换实例方法
*/
void hookClassMethodWithSwizz(Class originalClass, SEL originalSelector,
                              Class swizzledClass, SEL swizzledSelector);

/* hook 实例方法
  @param originalClass 原类
  @param originalSelector 原实例方法
  @param swizzledMethod   替换方法

  @return 原始函数IMP
  - example: 调用原始方法: ((void (*)(id, SEL, ...))retIMP)(self, _cmd, ...);
*/
IMP hookMethodWithSetIMP(Class originalClass, SEL originalSelector,
                         IMP swizzledMethod);
@end

@implementation HookHelper

void hookMethodWithSwizz(Class originalClass, SEL originalSelector,
                         Class swizzledClass, SEL swizzledSelector) {
  Method originalMethod =
      class_getInstanceMethod(originalClass, originalSelector);
  Method swizzledMethod =
      class_getInstanceMethod(swizzledClass, swizzledSelector);
  if (originalMethod && swizzledMethod) {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

void hookClassMethodWithSwizz(Class originalClass, SEL originalSelector,
                              Class swizzledClass, SEL swizzledSelector) {
  Method originalMethod = class_getClassMethod(originalClass, originalSelector);
  Method swizzledMethod = class_getClassMethod(swizzledClass, swizzledSelector);
  if (originalMethod && swizzledMethod) {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

IMP hookMethodWithSetIMP(Class originalClass, SEL originalSelector,
                         IMP swizzledMethod) {
  Method originalMethod =
      class_getInstanceMethod(originalClass, originalSelector);
  if (originalMethod) {
    return method_setImplementation(originalMethod, swizzledMethod);
  }
  return NULL;
}

@end
