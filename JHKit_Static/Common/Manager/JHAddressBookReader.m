//
//  JHAddressBookReader.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHAddressBookReader.h"
#import <AddressBook/ABRecord.h>

@implementation JHAddressBookReader
{
    NSArray *_contacts;
    BOOL _asynchronously;
}

static JHAddressBookReader *_sharedInstance;

+ (JHAddressBookReader *)sharedReader {
    @synchronized([JHAddressBookReader class]) {
        if(!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}

+ (id)alloc {
    @synchronized([JHAddressBookReader class]) {
        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    return nil;
}

- (void)readAddressBookOnCompletion:(TWAddressBookReaderBlock)completion {
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = nil;
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authorizationStatus == kABAuthorizationStatusAuthorized) {
        addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        [self readAddressBook:addressBook authorizationStatus:authorizationStatus onCompletion:completion];
    }
    else if (authorizationStatus == kABAuthorizationStatusDenied) {
        [self readAddressBook:addressBook authorizationStatus:authorizationStatus onCompletion:completion];
    }
    else if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
        addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            [self readAddressBook:addressBook authorizationStatus:granted? kABAuthorizationStatusAuthorized : kABAuthorizationStatusDenied onCompletion:completion];
        });
    }
    else if (authorizationStatus == kABAuthorizationStatusRestricted) {
        [self readAddressBook:addressBook authorizationStatus:authorizationStatus onCompletion:completion];
    }
}

- (void)readAddressBookAsynchronouslyOnCompletion:(TWAddressBookReaderBlock)completion {
    _asynchronously = YES;
    if (_asynchronously) {
        __weak id weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [weakSelf readAddressBookOnCompletion:completion];
        });
    }
}

- (void) readAddressBook:(ABAddressBookRef) addressBook authorizationStatus:(ABAuthorizationStatus) authorizationStatus onCompletion:(TWAddressBookReaderBlock) completion {
    if (addressBook){
        if (authorizationStatus == kABAuthorizationStatusAuthorized){
            CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
            CFIndex totalCount = ABAddressBookGetPersonCount(addressBook);
            if (completion) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completion([self contactsFromContacts:allPeople totalCount:totalCount], authorizationStatus);
                });
            }
        }
        else {
            if (completion) {
                completion(nil, authorizationStatus);
            }
        }
        CFRelease(addressBook);
    }
    else {
        if (completion) {
            completion(nil, authorizationStatus);
        }
    }
}

- (NSArray *)contactsFromContacts:(CFArrayRef)allPeople totalCount:(CFIndex)totalCount {
    
    NSMutableArray *contacts = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalCount; ++ i) {
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        CFStringRef abFirstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        
        NSString *firstName = (__bridge NSString *)abFirstName;
        NSString *lastName = (__bridge NSString *)abLastName;
        NSString *fullName = (__bridge NSString *)abFullName;
        
        if (abFirstName) CFRelease(abFirstName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
        
        JHContact *contact = [[JHContact alloc] init];
        contact.firstName = firstName;
        contact.lastName = lastName;
        contact.fullName = fullName;
        contact.recordId = (int)ABRecordGetRecordID(person);
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger totalMultiProperties = sizeof(multiProperties) / sizeof(ABPropertyID);
        
        for (NSInteger j = 0; j < totalMultiProperties; ++ j) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            
            if (valuesRef != nil) {
                valuesCount = ABMultiValueGetCount(valuesRef);
            }
            
            if (valuesCount == 0) {
                if(valuesRef!=nil){
                    CFRelease(valuesRef);
                }
                continue;
            }
            
            for (NSInteger k = 0; k < valuesCount; ++ k) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        NSString *phoneNumber = (__bridge NSString *)value;
                        [contact addPhoneNumber:phoneNumber];
                        break;
                    }
                    case 1: {// Email
                        NSString *email = (__bridge NSString *)value;
                        if(![contact.emails containsObject:email]){
                            [contact addEmail:email];
                        }
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        if (contact.phoneNumbers.count > 0 || contact.emails.count > 0) {
            [contacts addObject:contact];
        }
    }
    return contacts;
}

@end
