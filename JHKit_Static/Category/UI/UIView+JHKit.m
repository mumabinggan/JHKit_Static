//
//  UIView+Frame.m
//  JHKit
//
//  Created by muma on 16/9/30.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "UIView+JHKit.h"
#import "JHMacro.h"

@implementation UIView (Frame)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (CGFloat)maxY {
    return self.y + self.height;
}

- (void)setMaxY:(CGFloat)maxY {
    [self setY:maxY - self.height];
}

- (CGFloat)maxX {
    return self.x + self.width;
}

- (void)setMaxX:(CGFloat)maxX {
    [self setX:maxX - self.width];
}

- (CGFloat)midX {
    return self.x + self.width / 2;
}

- (void)setMidX:(CGFloat)midX {
    CGRect frame = self.frame;
    frame.origin.x = midX - self.width / 2;
    self.frame = frame;
}

- (CGFloat)midY {
    return self.y + self.height / 2;
}

- (void)setMidY:(CGFloat)midY {
    CGRect frame = self.frame;
    frame.origin.y = midY - self.height / 2;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect r = self.frame;
    r.origin = origin;
    self.frame = r;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect r = self.frame;
    r.size = size;
    self.frame = r;
}

@end

@implementation UIView (Corner)

- (void)addCorner:(JHRadius)radius
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor
  backgroundColor:(UIColor *)backgroundColor {
    UIImage *image = [UIImage imageWithRect:self.frame roundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:backgroundColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self insertSubview:imageView atIndex:0];
}

@end
