//
//  JHObject.h
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface JHObject : JSONModel
{
    CGFloat _contentHeight;
}

- (CGFloat)contentHeight;

- (NSString *)json;

- (NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithJSON:(NSString *)jsonString;

+ (NSArray *)ignoredProperties;

+ (Class)classForArray:(NSString *)propertyName;

@end
