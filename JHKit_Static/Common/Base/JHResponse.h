//
//  JHResponse.h
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHObject.h"

@interface JHResponse : JHObject

@property (nonatomic, strong) NSString *errorCode;

@property (nonatomic, strong) NSString *errorMessage;

@property (nonatomic, assign, readonly) BOOL success;

@property (nonatomic, strong, readonly) id responseObject;

@end
