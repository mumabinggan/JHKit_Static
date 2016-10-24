//
//  JHView.m
//  JHKit
//
//  Created by muma on 16/10/1.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHView.h"

@implementation JHView

- (id)initWithFrame:(CGRect)frame radius:(CGFloat)radius {
    self = [super initWithFrame:frame];
    if (self) {
        [self setRadius:radius];
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    
}

- (id)initWithFrame:(CGRect)frame difRadius:(JHRadius)radius {
    return [self initWithFrame:frame difRadius:radius backgroundColor:nil];
}

- (id)initWithFrame:(CGRect)frame difRadius:(JHRadius)radius backgroundColor:(UIColor *)backgroundColor {
    return [self initWithFrame:frame difRadius:radius borderWidth:0 borderColor:nil backgroundColor:backgroundColor];
}

- (id)initWithFrame:(CGRect)frame difRadius:(JHRadius)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor {
    self = [super initWithFrame:frame];
    if (self) {
        [self addCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:backgroundColor];
    }
    return self;
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    self.layer.cornerRadius = radius;
}

- (CGFloat)radius {
    return _radius;
}

- (void)setDifRadius:(JHRadius)difRadius {
    _difRadius = difRadius;
    [self addCorner:difRadius borderWidth:0 borderColor:nil backgroundColor:nil];
}

- (JHRadius)difRadius {
    return _difRadius;
}

@end
