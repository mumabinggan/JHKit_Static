//
//  JHNavigationController.m
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHNavigationController.h"

@interface JHNavigationController ()

@end

@implementation JHNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _autorotate = NO;
        _orientationMask = UIInterfaceOrientationMaskAll;
        _preferredOrientation = UIInterfaceOrientationPortrait;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setAutorotate:(BOOL)autorotate {
    _autorotate = autorotate;
}

- (BOOL)isAutorotate {
    return _autorotate;
}

- (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask {
    _orientationMask = orientationMask;
}

- (void)setPreferredOrientation:(UIInterfaceOrientation)preferredOrientation {
    _preferredOrientation = preferredOrientation;
}

- (BOOL)shouldAutorotate {
    return  _autorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return _orientationMask;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return _preferredOrientation;
}

- (void)setInteractivePopGestureRecognizerEnabled:(BOOL)enabled {
    if (iOS7_OR_LATER) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = enabled;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
