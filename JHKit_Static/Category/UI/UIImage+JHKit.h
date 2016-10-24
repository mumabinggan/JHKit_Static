//
//  UIImage+RoundCorner.h
//  JHKit
//
//  Created by muma on 16/10/3.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHMacro.h"

@interface UIImage (RoundCorner)

+ (UIImage *)imageWithRect:(CGRect)frame
             roundedCorner:(JHRadius)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)backgroundColor;

@end

@interface UIImage (TintColor)

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;

@end
