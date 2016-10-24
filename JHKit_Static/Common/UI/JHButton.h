//
//  JHButton.h
//  JHKit
//
//  Created by muma on 2016/10/17.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHButton : UIButton

@property (nonatomic, assign, readonly) JHRadius radius;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
    backgroundColor:(UIColor *)backgroundColor;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor
    attributedTitle:(NSAttributedString *)attributedTitle;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor
              title:(NSString *)title
         titleColor:(UIColor *)titleColor
               font:(UIFont *)font;

@end
