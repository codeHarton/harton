//
//  OCAutoReleasePoolViewController.m
//  Harton
//
//  Created by harton on 2021/10/12.
//

#import "OCAutoReleasePoolViewController.h"

@interface OCAutoReleasePoolViewController ()

@end

@implementation OCAutoReleasePoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        for (int i = 0; i < 100000; i++) {
            @autoreleasepool {
                __autoreleasing NSObject *obj = [[NSObject alloc] init];
                NSLog(obj.description);
            }
        }
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
