//
//  NSArray+Utilities.m
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "NSArray+JHKit.h"

@implementation NSArray (Utilities)

- (NSString *)join:(NSString *)string {
    return [self componentsJoinedByString:string];
}

@end
