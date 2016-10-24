//
//  JHAlert.h
//  JHKit
//
//  Created by muma on 2016/10/19.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JHAlertControllerAlertCompletionBlock)(NSInteger buttonIndex, UIAlertController *alertController);

typedef void(^JHAlertViewCompletionBlock)(NSInteger buttonIndex, UIAlertView *alertView);

typedef void(^JHAlertControllerActionSheetCompletionBlock)(NSInteger buttonIndex, UIAlertController *alertController);

typedef void(^JHActionSheetCompletionBlock)(NSInteger buttonIndex, UIActionSheet *actionSheet);

@interface JHAlert : NSObject
{
    UIAlertView *_alertView;
    UIActionSheet *_actionSheet;
}

+ (JHAlert *)sharedAlert;

// Wanring Actions
- (void)showWarningMessage:(NSString *)message;

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message;

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message onCompletion:(void(^)())completion;

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message autoCloseAfter:(double) duration;

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message autoCloseAfter:(double) duration onCompletion:(void(^)())completion;

// Notification View Actions
- (void)showNotificationMessage:(NSString *)message;

- (void)showNotificationMessage:(NSString *)message onCompletion:(void(^)())completion;

// Alert Actions
- (void)showAlertMessageInViewController:(UIViewController *)viewController message:(NSString *)message;

- (void)showAlertMessageInViewController:(UIViewController *)viewController message:(NSString *)message withTitle:(NSString *)title;

- (void)showAlertMessageInViewController:(UIViewController *)viewController message:(NSString *)message onCompletion:(JHAlertControllerAlertCompletionBlock)completion;

- (void)showAlertMessageInViewController:(UIViewController *)viewController
                                 message:(NSString *)message
                               withTitle:(NSString *)title
                            onCompletion:(JHAlertControllerAlertCompletionBlock)completion;

- (void)showConfirmMessageInViewController:(UIViewController *)viewController
                                   message:(NSString *)message
                                 withTitle:(NSString *)title
                              onCompletion:(JHAlertControllerAlertCompletionBlock)completion;

- (void)showConfirmMessageInViewController:(UIViewController *)viewController
                                   message:(NSString *)message
                                 withTitle:(NSString *)title
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                             okButtonTitle:(NSString *)okButtonTitle
                              onCompletion:(JHAlertControllerAlertCompletionBlock)completion;

// Action Sheet Actions
- (void)showActionSheetInViewController:(UIViewController *)viewController
                             completion:(JHAlertControllerActionSheetCompletionBlock)completion
                              withTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)showActionSheetInViewController:(UIViewController *)viewController
                             completion:(JHAlertControllerActionSheetCompletionBlock)completion
                              withTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitlesInArray:(NSArray *)otherButtonTitles;

@end

@interface JHAlert (AlertView)

// Alert view actions
- (void) showAlertMessage:(NSString*) message;

- (void) showAlertMessage:(NSString*) message withTitle:(NSString*) title;

- (void) showAlertMessage:(NSString*) message onCompletion:(JHAlertViewCompletionBlock)completion;

- (void) showAlertMessage:(NSString*) message
                withTitle:(NSString*) title
             onCompletion:(JHAlertViewCompletionBlock)completion;

- (void) showConfirmMessage:(NSString*) message
                  withTitle:(NSString*) title
               onCompletion:(JHAlertViewCompletionBlock)completion;

- (void) showConfirmMessage:(NSString*) message
                  withTitle:(NSString*) title
          cancelButtonTitle:(NSString*) cancelButtonTitle
              okButtonTitle:(NSString*) okButtonTitle
               onCompletion:(JHAlertViewCompletionBlock)completion;

@end

@interface JHAlert (ActionSheet)

// Action sheet
- (void) showActionSheetInView:(UIView*) view
                    completion:(JHActionSheetCompletionBlock)completion
                     withTitle:(NSString *)title
             cancelButtonTitle:(NSString*) cancelButtonTitle
        destructiveButtonTitle:(NSString*) destructiveButtonTitle
             otherButtonTitles:(NSString*) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void) showActionSheetInView:(UIView*) view
                    completion:(JHActionSheetCompletionBlock)completion
                     withTitle:(NSString *)title
             cancelButtonTitle:(NSString*) cancelButtonTitle
        destructiveButtonTitle:(NSString*) destructiveButtonTitle
      otherButtonTitlesInArray:(NSArray*) otherButtonTitles;

@end

@interface JHAlert (LoadingView)

- (void)showLoadingViewWithMessage:(NSString *)message inView:(UIView *)view;

- (void)removeLoadingView;

@end
