//
//  JHAddressBookReader.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "JHContact.h"

typedef void (^TWAddressBookReaderBlock)(NSArray *contacts, ABAuthorizationStatus authorizationStatus);

@interface JHAddressBookReader : NSObject

+ (JHAddressBookReader *)sharedReader;

- (void)readAddressBookOnCompletion:(TWAddressBookReaderBlock)completion;

- (void)readAddressBookAsynchronouslyOnCompletion:(TWAddressBookReaderBlock)completion;

@end
