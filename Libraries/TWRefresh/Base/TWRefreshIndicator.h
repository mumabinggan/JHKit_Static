//
//  TWRefreshIndicator.h
//  EasyBaking
//
//  Created by Chris on 10/6/15.
//  Copyright (c) 2015 iEasyNote. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TWRefreshIndicator <NSObject>

@optional
- (CGFloat)indicatorHeight;
- (void) start;
- (void) stop;
- (void) reset;
- (void) pullingWithRatio:(CGFloat) ratio;
- (void) pullingWithRatio:(CGFloat) ratio offset:(CGFloat)offset;

@end
