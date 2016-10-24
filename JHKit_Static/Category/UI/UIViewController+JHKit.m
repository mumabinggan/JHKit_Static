//
//  UIViewController+JHKit.m
//  JHKit
//
//  Created by muma on 2016/10/20.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "UIViewController+JHKit.h"
#import <objc/runtime.h>
#import "JHNetworkManager.h"
#import "JHRequest.h"
#import "JHResponse.h"

static NSString *LoadingViewKey = nil;

static NSString *RetryViewKey = nil;

@implementation UIViewController (UIAssistants)

// Warning Actions
- (void)showWarningMessage:(NSString *)message {
    [self showWarningMessage:message onCompletion:nil];
}

- (void)showWarningMessage:(NSString *)message onCompletion:(void (^)())completion {
    [self showWarningMessage:message autoCloseAfter:2.0 onCompletion:completion];
}

- (void)showWarningMessage:(NSString *)message autoCloseAfter:(double)duration {
    [self showWarningMessage:message autoCloseAfter:duration onCompletion:nil];
}

- (void)showWarningMessage:(NSString *)message autoCloseAfter:(double)duration onCompletion:(void (^)())completion {
    [[JHAlert sharedAlert] showWarningMessageInView:self.view message:message autoCloseAfter:duration onCompletion:completion];
}

// Alert Actions
- (void)showAlertMessage:(NSString *)message {
    [self showAlertMessage:message withTitle:nil];
}

- (void)showAlertMessage:(NSString *)message withTitle:(NSString *)title {
    [self showAlertMessage:message withTitle:title onCompletion:nil];
}

- (void)showAlertMessage:(NSString *)message onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [self showAlertMessage:message withTitle:nil onCompletion:completion];
}

- (void)showAlertMessage:(NSString *)message
               withTitle:(NSString *)title
            onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [self showConfirmMessage:message withTitle:title cancelButtonTitle:kStr(@"Close") okButtonTitle:nil onCompletion:completion];
}

- (void)showConfirmMessage:(NSString *)message withTitle:(NSString *)title
              onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [self showConfirmMessage:message withTitle:title cancelButtonTitle:kStr(@"Cancel") okButtonTitle:kStr(@"Ok") onCompletion:completion];
}

- (void)showConfirmMessage:(NSString *)message withTitle:(NSString *)title
         cancelButtonTitle:(NSString *)cancelButtonTitle
             okButtonTitle:(NSString *)okButtonTitle
              onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [[JHAlert sharedAlert] showConfirmMessageInViewController:self
                                                      message:message
                                                    withTitle:title
                                            cancelButtonTitle:cancelButtonTitle
                                                okButtonTitle:okButtonTitle
                                                 onCompletion:completion];
}

// Action Sheet Actions
- (void)showActionSheetOnCompletion:(JHAlertControllerActionSheetCompletionBlock)completion
                          withTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
             destructiveButtonTitle:(NSString *)destructiveButtonTitle
                  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    [[JHAlert sharedAlert] showActionSheetInViewController:self
                                                completion:completion
                                                 withTitle:title
                                                   message:message
                                         cancelButtonTitle:cancelButtonTitle
                                    destructiveButtonTitle:destructiveButtonTitle
                                         otherButtonTitles:otherButtonTitles, nil];
}

- (void) showActionSheetOnCompletion:(JHAlertControllerActionSheetCompletionBlock)completion
                           withTitle:(NSString *)title
                             message:(NSString *)message
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitlesInArray:(NSArray *)otherButtonTitles {
    
    [[JHAlert sharedAlert] showActionSheetInViewController:self
                                                completion:completion
                                                 withTitle:title
                                                   message:message
                                         cancelButtonTitle:cancelButtonTitle
                                    destructiveButtonTitle:destructiveButtonTitle
                                  otherButtonTitlesInArray:otherButtonTitles];
}

- (void)setRetryView:(UIView *)retryView {
    if (retryView) {
        objc_setAssociatedObject(self, &RetryViewKey, retryView, OBJC_ASSOCIATION_RETAIN);
    }
    else {
        objc_setAssociatedObject(self, &RetryViewKey, nil, OBJC_ASSOCIATION_RETAIN);
    }
}

- (UIView *)retryView {
    return objc_getAssociatedObject(self, &RetryViewKey);
}

// Loading View With Message
- (void)showLoadingViewWithMessage:(NSString *)loadingMessage {
    [self showLoadingViewWithMessage:loadingMessage inView:self.view];
}

- (void)showLoadingViewWithMessage:(NSString *)loadingMessage inView:(UIView *)view {
    [[JHAlert sharedAlert] showLoadingViewWithMessage:loadingMessage inView:view];
}

- (void)removeLoadingView {
    [[JHAlert sharedAlert] removeLoadingView];
}

// Retry View With Message
- (void)showRetryViewWithMessage:(NSString *)retryMessage {
    [self showRetryViewWithMessage:retryMessage inView:self.view];
}

- (void)showRetryViewWithMessage:(NSString *)retryMessage inView:(UIView *)view {
    
}

- (void)removeRetryView {
    
}

@end

@implementation UIViewController (Network)

- (void)get:(JHRequest *)request forResponseClass:(Class)clazz success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    [self get:request forResponseClass:clazz progress:nil success:success failure:failure];
}

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    [self post:request forResponseClass:clazz progress:nil success:success failure:failure];
}

- (void)get:(JHRequest *)request forResponseClass:(Class)clazz progress:(void (^)(NSProgress *))progress success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    if (request.showsLoadingView) {
        [self showsLoadingViewWithRequest:request];
    }
    [[JHNetworkManager sharedManager] get:request forResponseClass:clazz progress:^(NSProgress *downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(JHResponse *response) {
        if (success != nil) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure != nil) {
            failure(error);
        }
    }];
}

- (void)post:(JHRequest *)request forResponseClass:(Class)clazz progress:(void (^)(NSProgress *))progress success:(void (^)(JHResponse *))success failure:(void (^)(NSError *))failure {
    if (request.showsLoadingView) {
        [self showsLoadingViewWithRequest:request];
    }
    __weak JHRequest *weakRequest = request;
    __weak id weakSelf = self;
    [[JHNetworkManager sharedManager] post:request forResponseClass:clazz progress:^(NSProgress *uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(JHResponse *response) {
        if (weakRequest.showsLoadingView) {
            [weakSelf removeLoadingView];
        }
        if (success != nil) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (weakRequest.showsLoadingView) {
            [weakSelf removeLoadingView];
        }
        if (weakRequest.showsRetryView) {
            [weakSelf showsRetryViewWithRequest:weakRequest];
        }
        if (failure != nil) {
            failure(error);
        }
    }];
}

- (void)showsLoadingViewWithRequest:(JHRequest *)request {
    [self showLoadingViewWithMessage:request.loadingMessage];
}

- (void)showsRetryViewWithRequest:(JHRequest *)request {
    [self showRetryViewWithMessage:request.retryMessage];
}

@end
