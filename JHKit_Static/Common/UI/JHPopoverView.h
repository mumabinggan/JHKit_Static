//
//  JHPopoverView.h
//  JHKit
//
//  Created by muma on 2016/10/19.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHView.h"

typedef NS_ENUM(NSInteger, JHPopoverViewDirection) {
    JHPopoverViewDirectionFromTop,
    JHPopoverViewDirectionFromCenter,
    JHPopoverViewDirectionFromBottom,
};

typedef NS_ENUM(NSInteger, JHPopoverViewCloseDirection) {
    JHPopoverViewCloseDirectionFromTop,
    JHPopoverViewCloseDirectionFromCenter,
    JHPopoverViewCloseDirectionFromBottom,
};

typedef NS_ENUM(NSInteger, JHPopoverViewPosition) {
    JHPopoverViewPositionTop,
    JHPopoverViewPositionMiddle,
    JHPopoverViewPositionBottom,
    JHPopoverViewPositionCustom,
};

@interface JHPopoverView : JHView
{
    JHView *_maskView;
    
    JHPopoverViewDirection _direction;
    JHPopoverViewPosition _position;
    BOOL _enableDynamicAnimator;
}
@property (nonatomic, copy) void (^popviewWillShow)(JHPopoverView *view);
@property (nonatomic, copy) void (^popviewDidShow)(JHPopoverView *view);
@property (nonatomic, copy) void (^popviewWillClose)(JHPopoverView *view);
@property (nonatomic, copy) void (^popviewDidClose)(JHPopoverView *view);

@property (nonatomic, assign) BOOL closable; // Enable tap to close
@property (nonatomic, assign) BOOL enableDynamicAnimator;

@property (nonatomic, assign) JHPopoverViewDirection direction;
@property (nonatomic, assign) JHPopoverViewPosition position;
@property (nonatomic, assign) CGFloat positionY; // Only take effect when position set to JHPopoverViewPositionCustom
@property (nonatomic, strong) UIColor *maskColor;

@property (nonatomic, assign) JHPopoverViewCloseDirection closeDirection;

- (void)show;
- (void)showInView:(UIView *)view;
- (void)close;
- (void)closeOnCompletion:(void(^)(JHPopoverView *popoverView))completionBlock;

@end
