//
//  JHActionSheet.h
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHPopoverView.h"

@interface JHActionSheet : JHPopoverView

@property (nonatomic, copy) void (^selectAtIndex)(NSInteger index);

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesInArray:(NSArray*)otherButtonTitles;

- (void)setActionEnabled:(BOOL)enabled atIndex:(NSInteger)buttonIndex;

- (JHButton *) buttonAtIndex:(NSInteger)buttonIndex;

@end
