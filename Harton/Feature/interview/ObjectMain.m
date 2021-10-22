//
//  ObjectMain.m
//  Harton
//
//  Created by harton on 2021/10/17.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

int _main(int argc,const char *argv[]){
    @autoreleasepool {
        NSObject *obj = [[NSObject alloc] init];
        
        Class objclass = object_getClass(obj);
        
        [NSObject class];
        
//        objc_getClass(<#const char * _Nonnull name#>)
        
        
        void (^block)(void) = ^{
            NSLog(@"");
        };
        
        
        block();
    }
    return 0;
}
