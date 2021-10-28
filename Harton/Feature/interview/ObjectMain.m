//
//  ObjectMain.m
//  Harton
//
//  Created by harton on 2021/10/17.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
union{
    char bits;
} value ;
int _main(int argc,const char *argv[]){
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        BOOL name = value.bits & 0b00000001;
        
        Class objclass = object_getClass(obj);
        
        [NSObject class];
        
//        objc_getClass(<#const char * _Nonnull name#>)
        
        
        void (^block)(void) = ^{
            NSLog(@"");
        };
        
        NSInvocationOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
        }];
        
        operation.completionBlock = ^{
            
        };
        
        
        
        block();
    }
    return 0;
}
