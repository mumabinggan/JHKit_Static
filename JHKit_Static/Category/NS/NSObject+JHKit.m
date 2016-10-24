//
//  NSObject+Function.m
//  JHKit
//
//  Created by muma on 16/9/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "NSObject+JHKit.h"

@implementation NSObject (Function)

- (id)performSelector:(SEL)aSelector withObjects:firstObject, ... {
    id eachObject;
    va_list argumentList;
    NSMutableArray *objects = nil;
    if (firstObject) {
        va_start(argumentList, firstObject);
        objects = [[NSMutableArray alloc] init];
        [objects addObject:firstObject];
        while ((eachObject = va_arg(argumentList, id))) {
            [objects addObject:eachObject];
        }
        va_end(argumentList);
    }
    
    //1、创建签名对象
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    //2、判断传入的方法是否存在
    if (signature == nil) {
        //传入的方法不存在 就抛异常
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance", [self class], NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"方法没有" reason:info userInfo:nil];
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    NSInteger arguments = signature.numberOfArguments - 2;
    NSUInteger objectsCount = objects.count;
    NSInteger count = MIN(arguments, objectsCount);
    for (int i = 0; i < count; i++) {
        NSObject *obj = objects[i];
        //处理参数是NULL类型的情况
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        [invocation setArgument:&obj atIndex:i+2];
    }
    
    //6、调用NSinvocation对象
    [invocation invoke];
    
    //7、获取返回值
    id res = nil;
    //判断当前方法是否有返回值
    //    NSLog(@"methodReturnType = %s",signature.methodReturnType);
    //    NSLog(@"methodReturnTypeLength = %zd",signature.methodReturnLength);
    if (signature.methodReturnLength!=0) {
        //getReturnValue获取返回值
        [invocation getReturnValue:&res];
    }
    return res;
}

@end
