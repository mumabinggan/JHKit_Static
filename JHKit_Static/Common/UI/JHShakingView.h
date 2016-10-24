//
//  JHShakingView.h
//  JHKit
//
//  Created by muma on 2016/10/19.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHShakingView : JHView

@property (nonatomic, copy) void (^onShaking)();

@end
