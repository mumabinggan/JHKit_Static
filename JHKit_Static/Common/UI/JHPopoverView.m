//
//  JHPopoverView.m
//  JHKit
//
//  Created by muma on 2016/10/19.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHPopoverView.h"
//#import "TWConstants.h"

@interface JHPopoverView ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@interface JHPopoverView (AnimatorDelegate) <UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate>

@end

@implementation JHPopoverView
{
    UIDynamicAnimator *_animator;
    UIColor *_maskColor;
}

- (void)loadSubviews {
    _closable = YES;
    _position = JHPopoverViewPositionMiddle;
    _direction = JHPopoverViewDirectionFromTop;
    _maskColor = kRGBA(0, 0, 0, .35);
    _enableDynamicAnimator = YES;
    _closeDirection = JHPopoverViewCloseDirectionFromTop;
    [super loadSubviews];
}

- (void)show {
    UIWindow *window = [self window];
    if (window) {
        [self showInView:window];
    }
}

- (UIWindow *)window {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        for (NSInteger i = [UIApplication sharedApplication].windows.count - 1; i >= 0; --i) {
            window = [UIApplication sharedApplication].windows[i];
            if (window) {
                return window;
            }
        }
    }
    return window;
}

- (void)showInView:(UIView *)view {
    if (!_maskView) {
        _maskView = [[JHView alloc] initWithFrame:view.bounds];
        _maskView.backgroundColor = _maskColor;
        _maskView.layer.opacity = 0.0f;
        _maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMaskTapped:)];
        [_maskView addGestureRecognizer:tapGesture];
        [view addSubview:_maskView];
        [self displayInView:view];
    }
}

- (CGRect)popoverViewStartFrame:(UIView *)view {
    CGRect rect = self.frame;
    if (_direction == JHPopoverViewDirectionFromTop) {
        rect.origin.y = -rect.size.height;
    }
    else if (_direction == JHPopoverViewDirectionFromBottom) {
        rect.origin.y = view.height;
    }
    else if (_direction == JHPopoverViewDirectionFromCenter) {
        rect.origin.y = (view.height - self.height) / 2;
    }
    rect.origin.x = (view.width - rect.size.width) / 2;
    return rect;
}

- (CGRect)popoverViewEndFrame:(UIView *)view {
    CGRect rect = [self popoverViewStartFrame:view];
    if (_position == JHPopoverViewPositionMiddle) {
        rect.origin.y = (view.height - self.height) / 2;
    }
    else if (_position == JHPopoverViewPositionTop) {
        rect.origin.y = 0;
    }
    else if (_position == JHPopoverViewPositionBottom) {
        rect.origin.y = view.height - self.height;
    }
    else if (_position == JHPopoverViewPositionCustom) {
        rect.origin.y = _positionY;
    }
    return rect;
}

- (void)displayInView:(UIView *)view {
    self.frame = [self popoverViewStartFrame:view];
    [view addSubview:self];
    
    if (self.popviewWillShow) {
        self.popviewWillShow(self);
    }
    
    if (iOS7_OR_LATER && _enableDynamicAnimator && _direction == JHPopoverViewDirectionFromTop) {
        [UIView animateWithDuration:0.25 animations:^{
            _maskView.layer.opacity = 1.0;
        } completion:^(BOOL finished) {
        }];
        [self showWithDynamicAnimatorInView:view];
    }
    else {
        CGRect rect = [self popoverViewEndFrame:view];
        CGFloat duration = 0.25;
        if (_direction == JHPopoverViewDirectionFromCenter) {
            self.frame = rect;
            self.transform = CGAffineTransformMakeScale(1.10, 1.10);
        }
        
        [UIView animateWithDuration:duration animations:^{
            _maskView.layer.opacity = 1.0f;
            if (_direction == JHPopoverViewDirectionFromCenter) {
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            else {
                self.frame = rect;
            }
        } completion:^(BOOL finished) {
            if (self.popviewDidShow) {
                self.popviewDidShow(self);
            }
        }];
    }
}

- (void)showWithDynamicAnimatorInView:(UIView *)view {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:view];
    _animator.delegate = self;
    UIGravityBehavior *gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self]];
    gravityBeahvior.magnitude = 10.0;
    [_animator addBehavior:gravityBeahvior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self]];
    CGFloat y = (view.height + self.height) / 2;
    
    if (_position == JHPopoverViewPositionTop) {
        y = self.height;
    }
    else if (_position == JHPopoverViewPositionBottom) {
        y = view.height;
    }
    else if (_position == JHPopoverViewPositionCustom) {
        y = _positionY + self.height;
    }
    [collisionBehavior addBoundaryWithIdentifier:@"collisionBoundary"
                                       fromPoint:CGPointMake(0, y)
                                         toPoint:CGPointMake(view.width, y)];
    collisionBehavior.collisionDelegate = self;
    [_animator addBehavior:collisionBehavior];
}

- (void)close {
    [self closeOnCompletion:nil];
}

- (void)closeOnCompletion:(void (^)(JHPopoverView *popoverView))completionBlock {
    if (_animator && _animator.running) {
        return;
    }
    UIWindow *window = [self window];
    CGRect rect = self.frame;
    if (_closeDirection == JHPopoverViewCloseDirectionFromTop) {
        rect.origin.y = window.height;
    }
    else if (_closeDirection == JHPopoverViewCloseDirectionFromBottom) {
        rect.origin.y = -self.height;
    }
    if (self.popviewWillClose) {
        self.popviewWillClose(self);
    }
    CGFloat duration = 0.25;
    if (_closeDirection == JHPopoverViewCloseDirectionFromCenter) {
        duration = 0.01;
    }
    [UIView animateWithDuration:duration animations:^{
        self.frame = rect;
        if (_closeDirection == JHPopoverViewCloseDirectionFromCenter) {
            self.layer.opacity = 0.0;
        }
        if (_maskView) {
            _maskView.layer.opacity = 0.0f;
        }
    } completion:^(BOOL finished) {
        if(self.popviewDidClose){
            self.popviewDidClose(self);
        }
        if (completionBlock) {
            completionBlock(self);
        }
        if (_maskView) {
            [_maskView removeFromSuperview];
            _maskView = nil;
        }
        [self removeFromSuperview];
    }];
}

- (void)handleMaskTapped:(UITapGestureRecognizer *)recognizer {
    if (_closable) {
        [self close];
    }
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
}

- (void)dealloc {
    self.popviewWillClose = nil;
    self.popviewDidClose = nil;
    self.popviewWillShow = nil;
    self.popviewDidShow = nil;
    _animator = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

@end

@implementation JHPopoverView (AnimatorDelegate)

- (void) collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier{
}

- (void) dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    if (self.popviewDidShow) {
        self.popviewDidShow(self);
    }
}

@end
