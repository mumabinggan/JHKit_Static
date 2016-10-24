//
//  JHObject.m
//  JHKit
//
//  Created by muma on 16/10/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHObject.h"

@interface JHObject (JSONModel)

- (NSDictionary *)jsonModelDictionary;

- (NSString *)jsonModelJson;

@end

@implementation JHObject

- (CGFloat) contentHeight{
    if(_contentHeight==0){
        [self calculateContentHeight];
    }
    return _contentHeight;
}

- (void) calculateContentHeight{
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (!dictionary) {
        return nil;
    }
    NSError *error;
    JHObject *object = [self initWithDictionary:dictionary error:&error];
    if (error) {
        DLog(@"%@", error);
    }
    return object;
}

- (instancetype)initWithJSON:(NSString *)jsonString {
    if ([NSString isNullOrEmpty:jsonString]) {
        return nil;
    }
    NSError *error;
    JHObject *object = [self initWithString:jsonString error:&error];
    if (error) {
        DLog(@"%@", error);
    }
    return object;
}

- (NSDictionary *)dictionary {
    return [self jsonModelDictionary];
}

- (NSString *)json {
    return [self jsonModelJson];
}

+ (Class)classForArray:(NSString *)propertyName {
    return nil;
}

+ (NSArray *)ignoredProperties {
    return nil;
}

@end

@implementation JHObject (JSONModel)

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    NSArray *ignoredProperties = [self ignoredProperties];
    if (ignoredProperties && [ignoredProperties containsObject:propertyName]) {
        return YES;
    }
    return NO;
}

+ (NSString *)protocolForArrayProperty:(NSString *)propertyName {
    Class clazz = [self classForArray:propertyName];
    if (clazz) {
        return NSStringFromClass([clazz class]);
    }
    return nil;
}

- (NSDictionary *)jsonModelDictionary {
    return [super toDictionary];
}

- (NSString *)jsonModelJson {
    return [super toJSONString];
}

@end
