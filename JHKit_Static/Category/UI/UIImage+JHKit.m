//
//  UIImage+RoundCorner.m
//  JHKit
//
//  Created by muma on 16/10/3.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "UIImage+JHKit.h"

@implementation UIImage (RoundCorner)

+ (UIImage *)imageWithRect:(CGRect)frame
             roundedCorner:(JHRadius)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)backgroundColor {
    
    CGFloat minX = CGRectGetMinX(frame) + borderWidth/2;
    CGFloat midX = CGRectGetMidX(frame);
    CGFloat maxX = CGRectGetMaxX(frame) - borderWidth/2;
    CGFloat minY = CGRectGetMinY(frame) + borderWidth/2;
    CGFloat midY = CGRectGetMidY(frame);
    CGFloat maxY = CGRectGetMaxY(frame) - borderWidth/2;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //矩形，并填弃颜色
    CGContextSetLineWidth(context, borderWidth);//线的宽度
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);//线框颜色
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);//填充颜色
    
    CGContextMoveToPoint(context, minX, midY);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minX, minY, midX, minY, radius.ltRadius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, radius.rtRadius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius.rbRadius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, radius.lbRadius);
    // Close the path
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径

    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

@end

@implementation UIImage (TintColor)

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // draw alpha-mask
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);
    
    // draw tint color, preserving alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}

@end
