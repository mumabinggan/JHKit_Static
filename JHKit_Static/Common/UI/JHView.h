//
//  JHView.h
//  JHKit
//
//  Created by muma on 16/10/1.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMacro.h"

@interface JHView : UIView
{
    JHRadius _difRadius;
    CGFloat _radius;
}
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) JHRadius difRadius;

- (void)loadSubviews;

- (id)initWithFrame:(CGRect)frame
             radius:(CGFloat)radius;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
    backgroundColor:(UIColor *)backgroundColor;

- (id)initWithFrame:(CGRect)frame
          difRadius:(JHRadius)radius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
    backgroundColor:(UIColor *)backgroundColor;

@end
