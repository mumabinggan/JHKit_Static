//
//  JHBadgeView.m
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHBadgeView.h"
#import "JHLabel.h"

@implementation JHBadgeView
{
    JHLabel *_badgeLabel;
    CGFloat _badgeTextMargin;
}

- (void)loadSubviews {
    [super loadSubviews];
    
    _badgeTextMargin = 2;
    
    _badgeLabel = [[JHLabel alloc] initWithFrame:CGRectInset(self.bounds, -1, -1)];
    _badgeLabel.font = kAppFont(10);
    _badgeLabel.textColor = kWhiteColor;
    _badgeLabel.backgroundColor = kClearColor;
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_badgeLabel];
    
    self.radius = self.height / 2;
}

- (void)setBadgeColor:(UIColor *)badgeColor {
    self.backgroundColor = badgeColor;
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeLabel.textColor = badgeTextColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _badgeLabel.layer.borderColor = borderColor.CGColor;
}

- (void)setBadgeFont:(UIFont *)badgeFont {
    _badgeLabel.font = badgeFont;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _badgeLabel.layer.borderWidth = borderWidth;
}

- (void)setBadgeText:(NSString *)badgeText {
    _badgeLabel.text = badgeText;
    [_badgeLabel sizeToFit];
    CGRect r = _badgeLabel.frame;
    r.size.height = self.height;
    r.size.width = MAX(self.height, r.size.width + _badgeTextMargin * 2);
    _badgeLabel.frame = r;
    
    self.width = _badgeLabel.width;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.radius = self.height / 2;
    _badgeLabel.frame = CGRectInset(self.bounds, -1, -1);
    _badgeLabel.layer.cornerRadius = _badgeLabel.height / 2;
}

- (void)show:(BOOL)show {
    self.hidden = !show;
}

- (void)show:(BOOL)show badgeText:(NSString *)badgeText {
    [self show:show];
    self.badgeText = badgeText;
}

- (void)show:(BOOL)show badgeNumber:(NSInteger)badgeNumber {
    [self show:show badgeText:[NSString stringWithFormat:@"%ld", (long)badgeNumber]];
}

@end
