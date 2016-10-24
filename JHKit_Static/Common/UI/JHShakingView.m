//
//  JHShakingView.m
//  JHKit
//
//  Created by muma on 2016/10/19.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHShakingView.h"

@implementation JHShakingView

- (void)removeFromSuperview {
    [super removeFromSuperview];
}

- (void)dealloc {
    self.onShaking = nil;
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
    if (event.subtype == UIEventSubtypeMotionShake) {
        if(self.onShaking) {
            self.onShaking();
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
