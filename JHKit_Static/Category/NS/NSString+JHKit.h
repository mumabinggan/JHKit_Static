//
//  NSString+Utilities.h
//  JHKit
//
//  Created by muma on 16/9/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utilities)

- (BOOL)contains:(NSString*)string;

+ (NSString *)safeString:(NSString *)string;

+ (BOOL)isNullOrEmpty:(NSString *)string;

+ (BOOL)equals:(NSString *)str1 to:(NSString *)str2;

- (NSString*)base64:(BOOL)encoding;

- (NSComparisonResult)caseSensitiveCompare:(NSString *)aString;

- (CGSize)returnSize:(UIFont *)fnt;

- (CGSize)returnSize:(UIFont *)fnt maxWidth:(CGFloat)maxWidth;

- (CGSize)returnSize:(UIFont *)fnt maxWidth:(CGFloat)maxWidth lineSpacing:(CGFloat)lineSpacing;

- (NSString *)md5;

- (BOOL)containsCaseInsensitive:(NSString*)string;

- (BOOL)isValidEmail;

- (NSArray*)splitBy:(NSString *)splitString;

- (BOOL)isValidMobile;

- (BOOL)isWildMobile;

- (BOOL)isPureInteger;

- (BOOL)isPureFloat;

- (BOOL)isPureDouble;

- (NSString *)replace:(NSString *)string withString:(NSString *)replace;

- (NSString *)trim;

- (NSString*)add:(NSString*)string;

- (NSAttributedString *)addUnderline;

- (NSAttributedString *)addMidline;

@end
