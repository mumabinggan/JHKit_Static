//
//  NSString+Utilities.m
//  JHKit
//
//  Created by muma on 16/9/7.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "NSString+JHKit.h"
#import "JHMacro.h"
#import <CommonCrypto/CommonDigest.h>

#define kMaxEmailLength 64

@implementation NSString (Utilities)

- (BOOL)contains:(NSString*)string {
    return [self rangeOfString:string].location != NSNotFound;
}

+ (NSString *)safeString:(NSString *)string {
    return [NSString isNullOrEmpty:string] ? @"" : string;
}

+ (BOOL)isNullOrEmpty:(NSString *)string {
    return  !string || string==nil || (NSString*)[NSNull null]==string || [string isEqualToString:@""];
}

+ (BOOL)equals:(NSString *)str1 to:(NSString *)str2 {
    if([NSString isNullOrEmpty:str1]){
        return [NSString isNullOrEmpty:str2];
    }
    if([NSString isNullOrEmpty:str2]){
        return [NSString isNullOrEmpty:str1];
    }
    return [str1 isEqualToString:str2];
}

- (NSString*)base64:(BOOL)encoding {
    if([NSString isNullOrEmpty:self]){
        return @"";
    }
    if(encoding){
        NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
        if([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]){
            return [plainData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        }
        else if([plainData respondsToSelector:@selector(base64Encoding)]){
            return [plainData base64Encoding];
        }
    }
    else{
        NSData *decodedData = nil;
        if([[NSData alloc] respondsToSelector:@selector(initWithBase64EncodedString:options:)]){
            decodedData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];;
        }
        else if([[NSData alloc] respondsToSelector:@selector(initWithBase64Encoding:)]){
            decodedData = [[NSData alloc] initWithBase64Encoding:self];
        }
        NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
        return decodedString;
    }
    return self;
}

- (NSComparisonResult)caseSensitiveCompare:(NSString *)aString {
    return [self compare:aString options:NSLiteralSearch];
}

- (CGSize)returnSize:(UIFont *)fnt{
    CGSize size;
    if (iOS7_OR_LATER) {
        size = [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    }else{
        //size=[self sizeWithFont:fnt constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    }
    return size;
}

- (CGSize)returnSize:(UIFont *)fnt maxWidth:(CGFloat)maxWidth{
    CGSize size;
    if (iOS7_OR_LATER) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:fnt, NSParagraphStyleAttributeName:paragraphStyle.copy};
        size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        //size=[self sizeWithFont:fnt constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    }
    return size;
}

- (CGSize)returnSize:(UIFont *)fnt maxWidth:(CGFloat)maxWidth lineSpacing:(CGFloat)lineSpacing{
    CGSize size;
    if (iOS7_OR_LATER) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineSpacing;
        NSDictionary *attributes = @{NSFontAttributeName:fnt, NSParagraphStyleAttributeName:paragraphStyle.copy};
        size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }else{
        //size=[self sizeWithFont:fnt constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    }
    return size;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)containsCaseInsensitive:(NSString*)string {
    return [self rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound;
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validEmail = [emailTest evaluateWithObject:self];
    if(validEmail && self.length <= kMaxEmailLength)
        return YES;
    return NO;
}

- (NSArray*)splitBy:(NSString *)splitString {
    return [self componentsSeparatedByString: splitString];
}

- (BOOL)isValidMobile{
    return [self isWildMobile];
}

- (BOOL)isWildMobile{
    NSString * MOBILE = @"^\\d{11}$";
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regexTestMobile evaluateWithObject:self];
}

- (BOOL)isPureInteger {
    NSScanner* scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isPureDouble {
    NSScanner* scan = [NSScanner scannerWithString:self];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

- (NSString*) replace:(NSString *)string withString:(NSString *)replace{
    return [self stringByReplacingOccurrencesOfString:string withString:replace];
}

- (NSString*) trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString*)add:(NSString*)string {
    if(!string || string.length == 0)
        return self;
    return [self stringByAppendingString:string];
}

- (NSAttributedString *)addUnderline {
    NSDictionary *attribtDic = @{ NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    return [[NSAttributedString alloc] initWithString:[NSString safeString:self] attributes:attribtDic];;
}

- (NSAttributedString *)addMidline {
    NSDictionary *attribtDic = @{ NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    return [[NSAttributedString alloc] initWithString:[NSString safeString:self] attributes:attribtDic];;
}

@end
