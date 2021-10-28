//
//  ObjectViewController.m
//  Harton
//
//  Created by harton on 2021/10/23.
//

#import "ObjectViewController.h"
#import <objc/runtime.h>
union Data{
    char year;
    char month;
    char day;
    int age;
};


@interface ObjectPeople : NSObject
{
    int _age;
}
- (void)test;
@end

@implementation ObjectPeople

+ (void)test{
    NSLog(@"test");
}


@end

@interface ObjectViewController ()
- (void)test;
@end

@implementation ObjectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _age = 4;
    
    ObjectPeople *obj1 = ObjectPeople.new;
    ObjectPeople *obj2 = ObjectPeople.new;
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(UITextField.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"name is : %s,type is :%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    
    unsigned int count1;
    objc_property_t *p = class_copyPropertyList(ObjectPeople.class, &count1);
    
    [[NSThread alloc] initWithTarget:self selector:@selector(text) object:nil];
    NSLog(@"%p,%p",obj1,obj2);
}

- (void)test
{
    
    // Do any additional setup after loading the view.
    NSString *value = @"123";
    NSString *value1 = @"234";
    NSString *value2 = @"12433";
    
    id clas = [ObjectViewController class];
    void *obj = &clas;
    
    NSLog(@"%p,%p,%p,%p,%p,%p,%p",&self,&_cmd,&value,&value1,&value2,&clas,&obj);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

void c_other(id self,SEL _cmd)
{
    
}

- (void)other
{
    NSLog(@"%p",c_other);
}
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(test)) {
        Method method = class_getInstanceMethod(self, @selector(other));
        class_addMethod(self, sel, c_other , @"v16@0:8");
        return  true ;
        
        

        
        
    }
    return  false;
}
@end
