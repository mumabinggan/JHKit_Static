//
//  JHContact.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHContact.h"

@implementation JHContact
{
    NSMutableArray *_emails;
    NSMutableArray *_phoneNumbers;
}

- (id)init {
    self = [super init];
    if (self) {
        _emails = [NSMutableArray array];
        _phoneNumbers = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoneNumber:(NSString *)phoneNumber {
    if (![self.phoneNumbers containsObject:phoneNumber]) {
        [_phoneNumbers addObject:phoneNumber];
    }
}

- (void)addEmail:(NSString *)email{
    if (![self.emails containsObject:email]) {
        [_emails addObject:email];
    }
}

- (void)setPhoneNumbers:(NSArray *)phoneNumbers {
    [_phoneNumbers removeAllObjects];
    [self addPhoneNumbers:phoneNumbers];
}

- (NSArray *)phoneNumbers {
    return _phoneNumbers;
}

- (void)setEmails:(NSArray *)emails {
    [_emails removeAllObjects];
    [self addEmails:emails];
}

- (NSArray *)emails {
    return _emails;
}

- (void)addPhoneNumbers:(NSArray *)phoneNumbers {
    for (NSString *phoneNumber in phoneNumbers) {
        [self addPhoneNumber:phoneNumber];
    }
}

- (void)addEmails:(NSArray *)emails {
    for (NSString *email in emails) {
        [self addEmail:email];
    }
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[JHContact class]]) {
        return self.recordId == ((JHContact*)object).recordId;
    }
    return NO;
}

- (NSString *)name {
    return [NSString isNullOrEmpty:_fullName]? [NSString stringWithFormat:@"%@%@", _firstName, _lastName] : _fullName;
}

@end
