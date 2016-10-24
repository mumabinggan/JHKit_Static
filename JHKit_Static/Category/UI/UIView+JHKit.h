//
//  UIView+Frame.h
//  JHKit
//
//  Created by muma on 16/9/30.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat maxX;

@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGFloat midX;

@property (nonatomic, assign) CGFloat midY;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGSize size;

@end

@interface UIView (Corner)

- (void)addCorner:(JHRadius)radius
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor
  backgroundColor:(UIColor *)backgroundColor;

@end
