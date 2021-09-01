//
//  DDLogWrapper.h
//  Harton
//
//  Created by harton on 2021/8/31.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDLogWrapper : NSObject
+ (void)logError:(NSString *)message;
+ (void)logWarn:(NSString *)message;
+ (void)logInfo:(NSString *)message;
+ (void)logDebug:(NSString *)message;
+ (void)logVerbose:(NSString *)message;

+ (void)log:(NSString *)message level:(DDLogLevel)level;


@end

NS_ASSUME_NONNULL_END
