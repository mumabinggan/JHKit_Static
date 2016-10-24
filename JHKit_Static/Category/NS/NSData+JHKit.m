//
//  NSData+JHKit.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "NSData+JHKit.h"

@implementation NSData (JHKit)

- (NSString *)base64String {
    if([self respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    }
    return @"";
}

@end
