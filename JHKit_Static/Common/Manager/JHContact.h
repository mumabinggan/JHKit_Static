//
//  JHContact.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHObject.h"

@interface JHContact : JHObject

@property (nonatomic, assign) int recordId;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSArray *phoneNumbers;

@property (nonatomic, strong) NSArray *emails;

@property (nonatomic, strong, readonly) NSString *name;

- (void)addPhoneNumber:(NSString *)phoneNumber;

- (void)addEmail:(NSString *)email;

- (void)addPhoneNumbers:(NSArray *)phoneNumbers;

- (void)addEmails:(NSArray *)emails;

@end
