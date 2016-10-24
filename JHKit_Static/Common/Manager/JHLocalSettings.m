//
//  JHLocalSettings.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHLocalSettings.h"
#import "NSString+JHKit.h"

@implementation JHLocalSettings

static JHLocalSettings *_sharedInstance = nil;

+ (JHLocalSettings *)sharedSettings {
    @synchronized([JHLocalSettings class]) {
        if(!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}

+ (id)alloc {
    @synchronized([JHLocalSettings class]) {
        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    return nil;
}

- (id)settingsForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)setSettings:(id)settings forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeSettingsForKey:(NSString *)key {
    if (![NSString isNullOrEmpty:key]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)hasSettingForKey:(NSString *)key {
    return [self settingsForKey:key]? YES : NO;
}

@end
