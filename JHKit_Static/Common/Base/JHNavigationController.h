//
//  JHNavigationController.h
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHNavigationController : UINavigationController
{
    BOOL _autorotate;
    UIInterfaceOrientationMask _orientationMask;
    UIInterfaceOrientation _preferredOrientation;
}

@property (nonatomic, assign) BOOL autorotate;

- (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask;
- (void)setPreferredOrientation:(UIInterfaceOrientation)preferredOrientation;
- (void)setInteractivePopGestureRecognizerEnabled:(BOOL)enabled;

@end
