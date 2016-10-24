//
//  JHLocalSettings.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHObject.h"

@interface JHLocalSettings : JHObject

+ (JHLocalSettings *)sharedSettings;

- (id)settingsForKey:(NSString *)key;

- (void)setSettings:(id)settings forKey:(NSString *)key;

- (void)removeSettingsForKey:(NSString *)key;

- (BOOL)hasSettingForKey:(NSString *)key;

@end
