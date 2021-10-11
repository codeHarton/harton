//
//  MyProxy.m
//  Harton
//
//  Created by harton on 2021/9/29.
//

#import "MyProxy.h"

@implementation MyProxy
- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

//类方法
+ (instancetype)proxyWithTarget:(id)target {
    return [[MyProxy alloc] initWithTarget:target];
}


- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}



@end
