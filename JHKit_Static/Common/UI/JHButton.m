//
//  JHButton.m
//  JHKit
//
//  Created by muma on 2016/10/17.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHButton.h"

@implementation JHButton

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
    backgroundColor:(UIColor *)backgroundColor {
    return [self initWithFrame:frame difRadius:radius borderWidth:0 borderColor:kClearColor backgroundColor:backgroundColor];
}

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor {
    return [self initWithFrame:frame difRadius:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:kClearColor];
}

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor {
    return [self initWithFrame:frame difRadius:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:backgroundColor attributedTitle:nil];
}

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor
    attributedTitle:(NSAttributedString *)attributedTitle {
    self = [super initWithFrame:frame];
    if (self) {
        _radius = radius;
        UIImage *image = [UIImage imageWithRect:CGRectMake(0, 0, frame.size.width, frame.size.height) roundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:backgroundColor];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        if (attributedTitle) {
            [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
               font:(UIFont *)font {
    self = [super initWithFrame:frame];
    if (self) {
        _radius = radius;
        UIImage *image = [UIImage imageWithRect:CGRectMake(0, 0, frame.size.width, frame.size.height) roundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:backgroundColor];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = font;
    }
    return self;
}

@end
