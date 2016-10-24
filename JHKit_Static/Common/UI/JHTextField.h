//
//  JHTextField.h
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TWTextFieldPlaceholderAlignment) {
    TWTextFieldPlaceholderAlignmentLeft,
    TWTextFieldPlaceholderAlignmentCenter,
    TWTextFieldPlaceholderAlignmentRight,
};

@interface JHTextField : UITextField

@property (nonatomic, strong) UIColor *placeholderColor;

@property (nonatomic, assign) TWTextFieldPlaceholderAlignment placeholderAlignment;

@end
