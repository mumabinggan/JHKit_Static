//
//  JHViewController.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHViewController.h"

@interface JHViewController (NotificationInnerMethods)

- (void)__didReceivedNotification:(NSNotification *)notification;

- (void)__checkNotifications;

@end

@interface JHViewController (Autorotate)

@end

@implementation JHViewController
{
    NSMutableArray *_notifications;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _autorotate = NO;
        _orientationMask = UIInterfaceOrientationMaskAll;
        _preferredOrientation = UIInterfaceOrientationPortrait;
        _notificationType = JHNotificationTypeViewDidAppear;
        _shakingEnabled = NO;
        
        _enableApplicationDidBecomeActive = NO;
        _enableApplicationWillResignActive = NO;
        _enableApplicationDidEnterBackground = NO;
        _enableApplicationWillEnterForeground = NO;
        _enableApplicationWillTerminate = NO;
        
        _statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_notificationType == JHNotificationTypeViewWillAppear) {
        [self __checkNotifications];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_notificationType == JHNotificationTypeViewDidAppear) {
        [self __checkNotifications];
    }
}

- (void)dealloc {
    DLog(@"%@", self);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kNotificationRefreshRequired
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillTerminateNotification
                                                  object:nil];
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kWhiteColor;
    
    _notifications = [NSMutableArray array];
    
    // Lazy Notification Register
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__didReceivedNotification:) name:kNotificationRefreshRequired object:nil];
    
    // Application Notificagtions Register
}

- (void) setEnableApplicationDidBecomeActive:(BOOL)enableApplicationDidBecomeActive {
    if (_enableApplicationDidBecomeActive != enableApplicationDidBecomeActive) {
        _enableApplicationDidBecomeActive = enableApplicationDidBecomeActive;
        if (_enableApplicationDidBecomeActive) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidBecomeActive:)
                                                         name:UIApplicationDidBecomeActiveNotification
                                                       object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationDidBecomeActiveNotification
                                                          object:nil];
        }
    }
}

- (void)setEnableApplicationWillResignActive:(BOOL)enableApplicationWillResignActive {
    if (_enableApplicationWillResignActive != enableApplicationWillResignActive) {
        _enableApplicationWillResignActive = enableApplicationWillResignActive;
        if (_enableApplicationWillResignActive) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationWillResignActive:)
                                                         name:UIApplicationWillResignActiveNotification
                                                       object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationWillResignActiveNotification
                                                          object:nil];
        }
    }
}

- (void)setEnableApplicationDidEnterBackground:(BOOL)enableApplicationDidEnterBackground {
    if (_enableApplicationDidEnterBackground != enableApplicationDidEnterBackground) {
        _enableApplicationDidEnterBackground = enableApplicationDidEnterBackground;
        if (_enableApplicationDidEnterBackground) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidEnterBackground:)
                                                         name:UIApplicationDidEnterBackgroundNotification
                                                       object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationDidEnterBackgroundNotification
                                                          object:nil];
        }
    }
}

- (void)setEnableApplicationWillEnterForeground:(BOOL)enableApplicationWillEnterForeground {
    if (_enableApplicationWillEnterForeground != enableApplicationWillEnterForeground) {
        _enableApplicationWillEnterForeground = enableApplicationWillEnterForeground;
        if (_enableApplicationWillEnterForeground) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationWillEnterForeground:)
                                                         name:UIApplicationWillEnterForegroundNotification
                                                       object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationWillEnterForegroundNotification
                                                          object:nil];
        }
    }
}

- (void)setEnableApplicationWillTerminate:(BOOL)enableApplicationWillTerminate {
    if (_enableApplicationWillTerminate != enableApplicationWillTerminate) {
        _enableApplicationWillTerminate = enableApplicationWillTerminate;
        if (_enableApplicationWillTerminate) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationWillTerminate:)
                                                         name:UIApplicationWillTerminateNotification
                                                       object:nil];
        }
        else {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationWillTerminateNotification
                                                          object:nil];
        }
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
    if (event.subtype == UIEventSubtypeMotionShake) {
        [self didReceiveShaking];
    }
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    if (_statusBarStyle != statusBarStyle) {
        _statusBarStyle = statusBarStyle;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIStatusBarStyle)statusBarStyle {
    return _statusBarStyle;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

@end

@implementation JHViewController (Autorotate)

- (BOOL)shouldAutorotate {
    return _autorotate;
}

- (void) setAutorotate:(BOOL)autorotate{
    _autorotate = autorotate;
}

- (BOOL) isAutorotate{
    return _autorotate;
}

- (void) setOrientationMask:(UIInterfaceOrientationMask)orientationMask{
    _orientationMask = orientationMask;
}

- (void) setPreferredOrientation:(UIInterfaceOrientation)preferredOrientation{
    _preferredOrientation = preferredOrientation;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return _orientationMask;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return _preferredOrientation;
}

@end

@implementation JHViewController (Shaking)

- (void)didReceiveShaking {
    
}

@end

@implementation JHViewController (NotificationInnerMethods)

- (void)__didReceivedNotification:(NSNotification*)notification {
    NSNumber *number = notification.object;
    if (number) {
        [self addNotification:number.intValue];
    }
}

- (void)addNotification:(NSInteger)notification {
    if(![self containsNotification:notification]){
        [_notifications addObject:[NSNumber numberWithInteger:notification]];
    }
}

- (void)__checkNotifications {
    if (_notifications.count > 0) {
        for(NSNumber *number in _notifications){
            [self didReceiveNotification:number.integerValue];
        }
        [_notifications removeAllObjects];
    }
}

@end

@implementation JHViewController (Notification)

- (void)sendNotification:(NSInteger)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshRequired
                                                        object:[NSNumber numberWithInteger:notification]];
}

- (void)didReceiveNotification:(NSInteger)notification {
    
}

- (BOOL)containsNotification:(NSInteger)notification {
    NSNumber *number = [NSNumber numberWithInteger:notification];
    return [_notifications containsObject:number];
}

@end

@implementation JHViewController (Application)

- (void)applicationDidBecomeActive:(NSNotification *)notification { }

- (void)applicationWillResignActive:(NSNotification *)notification { }

- (void)applicationDidEnterBackground:(NSNotification *)notification { }

- (void)applicationWillEnterForeground:(NSNotification *)notification { }

- (void)applicationWillTerminate:(NSNotification *)notification { }

@end
