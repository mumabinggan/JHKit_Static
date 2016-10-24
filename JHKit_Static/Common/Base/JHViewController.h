//
//  JHViewController.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JHNotificationType) {
    JHNotificationTypeViewDidAppear,
    JHNotificationTypeViewWillAppear,
};

@interface JHViewController : UIViewController
{
    BOOL _autorotate;
    BOOL _shakingEnabled;
    
    UIInterfaceOrientationMask _orientationMask;
    UIInterfaceOrientation _preferredOrientation;
    
    UIStatusBarStyle _statusBarStyle;
    JHNotificationType _notificationType;
    
    BOOL _enableApplicationDidBecomeActive;
    BOOL _enableApplicationWillResignActive;
    BOOL _enableApplicationDidEnterBackground;
    BOOL _enableApplicationWillEnterForeground;
    BOOL _enableApplicationWillTerminate;
}

@property (nonatomic, assign) BOOL autorotate;
@property (nonatomic, assign) BOOL shakingEnabled;
@property (nonatomic, assign) UIInterfaceOrientationMask orientationMask;
@property (nonatomic, assign) UIInterfaceOrientation preferredOrientation;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, assign) JHNotificationType notificationType;

@property (nonatomic, assign) BOOL enableApplicationDidBecomeActive;
@property (nonatomic, assign) BOOL enableApplicationWillResignActive;
@property (nonatomic, assign) BOOL enableApplicationDidEnterBackground;
@property (nonatomic, assign) BOOL enableApplicationWillEnterForeground;
@property (nonatomic, assign) BOOL enableApplicationWillTerminate;

@end

// Lazy Notification Category
@interface JHViewController (Notification)

- (void)sendNotification:(NSInteger)notification;

- (void)didReceiveNotification:(NSInteger)notification;

- (BOOL)containsNotification:(NSInteger)notification;

@end

// Shaking Category
@interface JHViewController (Shaking)

- (void)didReceiveShaking;

@end

// App Status Detector
@interface JHViewController (Application)

- (void)applicationDidBecomeActive:(NSNotification *)notification;

- (void)applicationWillResignActive:(NSNotification *)notification;

- (void)applicationDidEnterBackground:(NSNotification *)notification;

- (void)applicationWillEnterForeground:(NSNotification *)notification;

- (void)applicationWillTerminate:(NSNotification *)notification;

@end
