//
//  JHActionSheet.m
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHActionSheet.h"
#import "JHLabel.h"
#import "JHButton.h"
#import "NSString+JHKit.h"

@implementation JHActionSheet
{
    NSString *_title;
    NSString *_cancelButtonTitle;
    NSString *_destructiveButtonTitle;
    
    NSMutableArray *_otherButtons;
    
    JHView *_buttonsView;
    JHLabel *_titleLabel;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)otherButtonTitles, ... {
    self = [super init];
    if (self) {
        _title = title;
        _cancelButtonTitle = cancelButtonTitle;
        _destructiveButtonTitle = destructiveButtonTitle;
        _otherButtons = [NSMutableArray array];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [_otherButtons addObject:arg];
        }
        va_end(args);
        
        [self loadSubviews];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesInArray:(NSArray *)otherButtonTitles {
    self = [super init];
    if (self) {
        _title = title;
        _cancelButtonTitle = cancelButtonTitle;
        _destructiveButtonTitle = destructiveButtonTitle;
        _otherButtons = [NSMutableArray array];
        [_otherButtons addObjectsFromArray:otherButtonTitles];
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    [super loadSubviews];
    
    self.direction = JHPopoverViewDirectionFromBottom;
    self.position = JHPopoverViewPositionCustom;
    
    CGFloat buttonHeight = 49;
    CGFloat titleHeight = 44;
    CGFloat spacing = 8;
    CGFloat height = _otherButtons.count * buttonHeight;
    CGFloat cancelHeight = spacing;
    if (![NSString isNullOrEmpty:_title]) {
        height += titleHeight;
    }
    if (![NSString isNullOrEmpty:_destructiveButtonTitle]) {
        height += buttonHeight;
    }
    if (![NSString isNullOrEmpty:_cancelButtonTitle]) {
        cancelHeight += buttonHeight + spacing;
    }
    self.frame = CGRectMake(0, 0, kDeviceWidth, height + cancelHeight);
    
    self.positionY = kDeviceHeight - self.frame.size.height;
    
    NSInteger buttonIndex = 10000;
    
    CGFloat radius = 8;
    
    if (height > 0) {
        _buttonsView = [[JHView alloc] initWithFrame:CGRectMake(spacing, 0, self.frame.size.width - spacing * 2, height) radius:radius];
        _buttonsView.backgroundColor = kWhiteColor;
        [self addSubview:_buttonsView];
        CGFloat top = 0;
        BOOL line = NO;
        CGFloat buttonRadius = radius;
        if (![NSString isNullOrEmpty:_title]) {
            _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(radius, radius, _buttonsView.frame.size.width - radius * 2, titleHeight - radius*2)];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.text = _title;
            _titleLabel.font = kAppFont(14);
            _titleLabel.textColor = kGrayColor;
            [_buttonsView addSubview:_titleLabel];
            
            top += titleHeight;
            line = YES;
            buttonRadius = 0;
        }
        if (![NSString isNullOrEmpty:_destructiveButtonTitle]) {
            if (line) {
                JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, top, _buttonsView.frame.size.width, 0.5)];
                lineView.backgroundColor = kRGBA(0, 0, 0, 0.15);
                [_buttonsView addSubview:lineView];
            }
            
            JHRadius difRadius = JHRadiusMake(0, 0, 0, 0);
            if (buttonRadius > 0) {
                difRadius.ltRadius = difRadius.rtRadius = buttonRadius;
            }
            if (_otherButtons.count==0) {
                difRadius.lbRadius = difRadius.rbRadius = radius;
            }
            JHButton *destructiveButton = [[JHButton alloc] initWithFrame:CGRectMake(0, top, _buttonsView.frame.size.width, buttonHeight) difRadius:difRadius borderWidth:0 borderColor:kClearColor backgroundColor:kWhiteColor title:_destructiveButtonTitle titleColor:kRedColor font:kAppFont(18)];
            destructiveButton.tag = buttonIndex++;
            [destructiveButton addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonsView addSubview:destructiveButton];
            /*
            JHButton *destructiveButton = [JHButton buttonWithType:UIButtonTypeCustom];
            destructiveButton.frame = CGRectMake(0, top, _buttonsView.frame.size.width, buttonHeight);
            [destructiveButton setTitleColor:kRedColor forState:UIControlStateNormal];
            [destructiveButton setTitle:_destructiveButtonTitle forState:UIControlStateNormal];
            destructiveButton.tag = buttonIndex++;
            destructiveButton.titleLabel.font = kAppFont(18);
            [destructiveButton addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonsView addSubview:destructiveButton];
            if (buttonRadius > 0) {
                destructiveButton.ltRadius = destructiveButton.rtRadius = buttonRadius;
            }
            if (_otherButtons.count==0) {
                destructiveButton.lbRadius = destructiveButton.rbRadius = radius;
            }
             */
            top += buttonHeight;
            line = YES;
            buttonRadius = 0;
        }
        for (NSInteger i = 0, n = _otherButtons.count; i < n; ++ i) {
            if (line) {
                JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, top, _buttonsView.frame.size.width, 0.5)];
                lineView.backgroundColor = kRGBA(0, 0, 0, 0.15);
                [_buttonsView addSubview:lineView];
            }
            
            JHRadius difRadius = JHRadiusMake(0, 0, 0, 0);
            if (buttonRadius > 0 && i == 0) {
                difRadius.ltRadius = difRadius.rtRadius = buttonRadius;
                buttonRadius = 0;
            }
            if (i == n-1) {
                difRadius.lbRadius = difRadius.rbRadius = radius;
            }
            JHButton *button = [[JHButton alloc] initWithFrame:CGRectMake(0, top, _buttonsView.frame.size.width, buttonHeight) difRadius:difRadius borderWidth:0 borderColor:kClearColor backgroundColor:kWhiteColor title:[_otherButtons objectAtIndex:i] titleColor:kRGB(52, 138, 247) font:kAppFont(18)];
            [button setTitleColor:kGrayColor forState:UIControlStateDisabled];
            /*
            JHButton *button = [JHButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, top, _buttonsView.frame.size.width, buttonHeight);
            [button setTitle:[_otherButtons objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:kRGB(52, 138, 247) forState:UIControlStateNormal];
            button.titleLabel.font = kAppFont(18);
            [button setTitleColor:kGrayColor forState:UIControlStateDisabled];
            if (buttonRadius > 0 && i == 0) {
                button.ltRadius = button.rtRadius = buttonRadius;
                buttonRadius = 0;
            }
            if (i == n-1) {
                button.lbRadius = button.rbRadius = radius;
            }
             */
            [button addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = buttonIndex ++;
            [_buttonsView addSubview:button];
            top += buttonHeight;
            line = YES;
        }
    }
    if (cancelHeight>8) {
        JHView *view = [[JHView alloc] initWithFrame:CGRectMake(_buttonsView.frame.origin.x, _buttonsView.frame.origin.y+_buttonsView.frame.size.height+8, _buttonsView.frame.size.width, buttonHeight) radius:radius];
        view.backgroundColor = kWhiteColor;
        [self addSubview:view];
        
        JHButton *cancelButton = [[JHButton alloc] initWithFrame:view.bounds difRadius:JHRadiusMake(view.radius, view.radius, view.radius, view.radius) borderWidth:0 borderColor:nil backgroundColor:kWhiteColor title:_cancelButtonTitle titleColor:kRGB(52, 138, 247) font:kAppFontBold(18)];
        /*
        JHButton *cancelButton = [JHButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        cancelButton.frame = view.bounds;
        cancelButton.radius = view.radius;
        cancelButton.titleLabel.font = kAppFontBold(18);
        [cancelButton setTitleColor:kRGB(52, 138, 247) forState:UIControlStateNormal];
         */
        [cancelButton addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.tag = buttonIndex ++;
        [view addSubview:cancelButton];
    }
    
    // Create blur effect
    if (NSClassFromString(@"UIVisualEffectView") != nil) {
        _buttonsView.backgroundColor = kClearColor;
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:_buttonsView.bounds];
        effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        effectView.layer.cornerRadius = _buttonsView.radius;
        effectView.layer.masksToBounds = YES;
        [_buttonsView insertSubview:effectView atIndex:0];
    }
}

- (void)handleButtonClicked:(JHButton *)sender {
    __weak id weakSelf = self;
    [self closeOnCompletion:^(JHPopoverView *popoverView){
        if ([weakSelf selectAtIndex]) {
            [weakSelf selectAtIndex](sender.tag-10000);
        }
    }];
}

- (void) setActionEnabled:(BOOL)enabled atIndex:(NSInteger)buttonIndex {
    if (_buttonsView) {
        JHButton *button = (JHButton*)[_buttonsView viewWithTag:buttonIndex + 10000];
        if (button) {
            button.enabled = enabled;
        }
    }
}

- (JHButton*) buttonAtIndex:(NSInteger)buttonIndex {
    if (_buttonsView) {
        return (JHButton*)[_buttonsView viewWithTag:buttonIndex + 10000];
    }
    return nil;
}

@end
