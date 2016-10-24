//
//  JHResponse.m
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHResponse.h"

@implementation JHResponse

- (BOOL)success {
    if (![NSString isNullOrEmpty:_errorCode]) {
        return _errorCode.intValue == 0;
    }
    return NO;
}

@end
