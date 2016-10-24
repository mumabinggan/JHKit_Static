//
//  NSObject+Function.h
//  JHKit
//
//  Created by muma on 16/9/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Function)

//- (id)performSelector:(SEL)aSelector withObjects:(NSArray*)objects;

- (id)performSelector:(SEL)aSelector withObjects:firstObject, ...NS_REQUIRES_NIL_TERMINATION;

@end
