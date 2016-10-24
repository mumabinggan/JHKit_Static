//
//  JHTextField.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHTextField.h"

@implementation JHTextField

- (void)drawPlaceholderInRect:(CGRect)rect {
    if (iOS7_OR_LATER) {
        if (_placeholderColor) {
            CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
            CGFloat x = 0;
            if (_placeholderAlignment == TWTextFieldPlaceholderAlignmentCenter) {
                CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:self.font}];
                x = MAX(0, (self.width - placeholderSize.width) / 2);
            }
            else if (_placeholderAlignment == TWTextFieldPlaceholderAlignmentRight) {
                CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:self.font}];
                x = MAX(0, (self.width - placeholderSize.width));
            }
            [self.placeholder drawAtPoint:CGPointMake(x, (rect.size.height / 2 - textSize.height / 2 - .5))
                           withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:_placeholderColor}];
        }
        else {
            [super drawPlaceholderInRect:rect];
        }
    }
    else {
        [super drawPlaceholderInRect:rect];
    }
}

@end
