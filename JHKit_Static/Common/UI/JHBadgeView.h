//
//  JHBadgeView.h
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHView.h"

typedef NS_ENUM(NSInteger, JHBadgeViewStyle) {
    JHBadgeViewStylePlain,
    JHBadgeViewStyleText,
};

@interface JHBadgeView : JHView

@property (nonatomic, assign) JHBadgeViewStyle badgeStyle;

@property (nonatomic, strong) UIColor *badgeColor;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIColor *badgeTextColor;

@property (nonatomic, strong) UIFont *badgeFont;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) NSString *badgeText;

@property (nonatomic, assign) CGFloat badgeTextMargin; // Default 2 pixel,

- (void)show:(BOOL)show;

- (void)show:(BOOL)show badgeText:(NSString *)badgeText;

- (void)show:(BOOL)show badgeNumber:(NSInteger)badgeNumber;

@end
