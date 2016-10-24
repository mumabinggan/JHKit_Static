//
//  UIColor+RGB.m
//  JHKit
//
//  Created by muma on 16/10/4.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "UIColor+JHKit.h"

@implementation UIColor (RGB)

- (CGFloat)redFloat {
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[0];
}

- (CGFloat)greenFloat {
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[1];
}

- (CGFloat)blueFloat {
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[2];
}

- (CGFloat)alphaFloat {
    const CGFloat *rgba = CGColorGetComponents(self.CGColor);
    return rgba[3];
}

@end
