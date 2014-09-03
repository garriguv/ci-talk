#import "UIApplication+Specs.h"

#import <objc/runtime.h>

@implementation UIApplication (Specs)

+ (void)initialize {
    SEL new = @selector(swizzled_loadMainInterface);
    SEL orig = NSSelectorFromString(@"_loadMainInterfaceFile");
    Class c = [self class];
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);

    if (class_addMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
        class_replaceMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    } else {
        method_exchangeImplementations(newMethod, origMethod);
    }
}

- (void)swizzled_loadMainInterface
{
    // Prevent Main storyboard from being initialized during testing
}

@end
