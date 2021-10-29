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
@property (nonatomic,copy) NSString *name;

- (void)test;
@end

@implementation ObjectPeople

+ (void)test{
    NSLog(@"test");
}




@end

@interface MyOperation : NSOperation
@end

@implementation MyOperation

- (BOOL)isAsynchronous{

    return YES;
    
}

- (void)main
{
    NSLog(@"main %@",NSThread.currentThread);
}

- (void)start
{
    NSLog(@"start %@",NSThread.currentThread);

}

@end



@interface ObjectViewController ()
- (void)test;

@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)ObjectPeople  *person;


@end

@implementation ObjectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [ObjectPeople new];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
 
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.person.name = @"100";

    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
    });
    dispatch_resume(timer);
}


- (void)dealloc
{
    [self.person removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%s,,%@",__func__,change);
}

- (void)test101
{
    // 1.创建一个string字符串。
       NSString *string = @"github.com/pro648";
       NSString *stringB = string;
       NSString *stringCopy = [string copy];
       NSMutableString *stringMutableCopy = [string mutableCopy];
       
       // 2.输出指针指向的内存地址。
       NSLog(@"Memory location of string = %p",string);
       NSLog(@"Memory location of stringB = %p",stringB);
       NSLog(@"Memory location of stringCopy = %p",stringCopy);
       NSLog(@"Memory location of stringMutableCopy = %p",stringMutableCopy);
}
- (void)run
{
    NSLog(@"333 %@",NSThread.currentThread);
}

- (void)_test
{
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
