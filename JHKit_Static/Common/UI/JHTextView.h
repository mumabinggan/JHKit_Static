//
//  JHTextView.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTextView : UITextView

@property (nonatomic, copy) void (^textDidChange)(JHTextView *textView);

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

@end
