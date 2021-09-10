//
//  DDLogWrapper.m
//  Harton
//
//  Created by harton on 2021/8/31.
//

#import "DDLogWrapper.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
// 定义Log等级
static const DDLogLevel ddLogLevel = DDLogLevelDebug;

@implementation DDLogWrapper

+(void)logError:(NSString *)message{
    DDLogError(@"%@",message);
}
+(void)logWarn:(NSString *)message{
    DDLogWarn(@"%@",message);
}
+(void)logInfo:(NSString *)message{
    DDLogInfo(@"%@",message);
}
+(void)logDebug:(NSString *)message{
    DDLogDebug(@"%@",message);
}
+(void)logVerbose:(NSString *)message{
    DDLogVerbose(@"%@",message);
}


+ (void)load{

//    NSError *error = nil;
//    [UIButton aspect_hookSelector:@selector(sendAction:to:forEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
//       // NSLog(@"------收到点击事件 id  = %@",info.instance);
//        [SVProgressHUD showWithStatus:@"点击"];
//        [SVProgressHUD dismissWithDelay:1];
//    } error:&error];
}


@end
