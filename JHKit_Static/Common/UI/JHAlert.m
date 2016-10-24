//
//  JHAlert.m
//  JHKit
//
//  Created by muma on 2016/10/19.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "JHAlert.h"
#import "NSString+JHKit.h"
#import "JHView.h"
#import "JHLabel.h"
#import "JHPopoverView.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static NSString *TW_ALERT_COMPLETION_BLOCK_KEY = nil;

static NSString *TW_ACTIONSHEET_COMPLETION_BLOCK_KEY = nil;

@interface JHWarningMessageView : JHPopoverView

@property (nonatomic, strong) NSString *message;

@end

@interface JHAlert (AlertDelegate) <UIAlertViewDelegate>

@end

@interface JHAlert (ActionSheetDelegate) <UIActionSheetDelegate>

@end

@implementation JHWarningMessageView
{
    JHLabel *_messageLabel;
}

- (void)loadSubviews {
    [super loadSubviews];
    
    _messageLabel = [[JHLabel alloc] initWithFrame:CGRectInset(self.bounds, 8, 3)];
    _messageLabel.font = kAppFont(14);
    _messageLabel.textColor = kWhiteColor;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.numberOfLines = 0;
    [self addSubview:_messageLabel];
}

- (void)setMessage:(NSString *)message {
    _messageLabel.text = message;
    [_messageLabel sizeToFit];
    
    CGRect r = _messageLabel.frame;
    r.size.width = self.frame.size.width;
    r.size.height = MAX(r.size.height + 3*2, 44);
    r.origin = CGPointZero;
    self.frame = r;
    _messageLabel.frame = CGRectInset(self.bounds, 8, 3);
}

@end

@implementation JHAlert
{
    JHView *_notificationMessageView;
    JHWarningMessageView *_warningMessageView;
    CGFloat _notificationViwePanned;
    MBProgressHUD *_loadingView;
}

static JHAlert *_sharedInstance = nil;

+ (JHAlert *)sharedAlert {
    @synchronized([JHAlert class]) {
        if(!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        return _sharedInstance;
    }
    return nil;
}

+ (id)alloc {
    @synchronized([JHAlert class]) {
        NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    return nil;
}

// Wanring Actions
- (void)showWarningMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window && [UIApplication sharedApplication].windows.count > 0) {
        window = [UIApplication sharedApplication].windows[0];
    }
    if (window) {
        [self showWarningMessageInView:window message:message];
    }
}

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message {
    [self showWarningMessageInView:view message:message onCompletion:nil];
}

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message onCompletion:(void(^)())completion {
    [self showWarningMessageInView:view message:message autoCloseAfter:2.0 onCompletion:completion];
}

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message autoCloseAfter:(double) duration {
    [self showWarningMessageInView:view message:message autoCloseAfter:duration onCompletion:nil];
}

- (void)showWarningMessageInView:(UIView *)view message:(NSString *)message autoCloseAfter:(double) duration onCompletion:(void(^)())completion {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideWarningMessageView) object:nil];
    if (!_warningMessageView) {
        _warningMessageView = [[JHWarningMessageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth - 16 * 2, 60) radius:4.0];
        _warningMessageView.backgroundColor = kRGBA(0, 0, 0, 0.75);
        _warningMessageView.direction = JHPopoverViewDirectionFromCenter;
        __weak id weakSelf = self;
        _warningMessageView.closable = NO;
        _warningMessageView.popviewDidClose = ^(JHPopoverView *view) {
            [weakSelf handleHideWarningMessageView];
        };
    }
    _warningMessageView.message = message;
    [_warningMessageView showInView:view];
    
    [self performSelector:@selector(hideWarningMessageView) withObject:nil afterDelay:duration];
}

- (void)hideWarningMessageView {
    [_warningMessageView close];
}

- (void)handleHideWarningMessageView {
    _warningMessageView = nil;
}

// Notification View Actions
- (void)showNotificationMessage:(NSString *)message {
    [self showNotificationMessage:message onCompletion:nil];
}

- (void)showNotificationMessage:(NSString *)message onCompletion:(void (^)())completion {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideNotificationMessageView) object:nil];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!_notificationMessageView) {
        _notificationMessageView = [[JHView alloc] initWithFrame:CGRectMake(0, -64, kDeviceWidth, 64) radius:0];
        _notificationMessageView.backgroundColor = kRGBA(55, 55, 55, 0.95);
        [window addSubview:_notificationMessageView];
        
        JHLabel *messageLabel = [[JHLabel alloc] initWithFrame:CGRectInset(_notificationMessageView.bounds, 16, 16)];
        messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        messageLabel.font = kAppFont(14);
        messageLabel.textColor = kWhiteColor;
        messageLabel.tag = 100;
        [_notificationMessageView addSubview:messageLabel];
        
        JHView *v = [[JHView alloc] initWithFrame:CGRectMake((_notificationMessageView.frame.size.width-36)/2, _notificationMessageView.frame.size.height-10, 36, 6) radius:3];
        v.backgroundColor = kRGBA(255, 255, 255, 0.5);
        [_notificationMessageView addSubview:v];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNotificationViewPan:)];
        [_notificationMessageView addGestureRecognizer:panGesture];
    }
    JHLabel *messageLabel = (JHLabel*)[_notificationMessageView viewWithTag:100];
    if (messageLabel) {
        messageLabel.text = message;
    }
    if (completion) {
        objc_setAssociatedObject(_notificationMessageView, @"completionBlock", completion, OBJC_ASSOCIATION_COPY);
    }
    [self showNotificationMessageView];
}

- (void)showNotificationMessageView {
    CGRect r = _notificationMessageView.frame;
    r.origin.y = 0;
    [UIView animateWithDuration:0.30 animations:^{
        _notificationMessageView.frame = r;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideNotificationMessageView) withObject:nil afterDelay:2.0];
    }];
}

- (void)hideNotificationMessageView {
    CGRect r = _notificationMessageView.frame;
    r.origin.y = -r.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        _notificationMessageView.frame = r;
    } completion:^(BOOL finished) {
        void(^completionBlock)() = objc_getAssociatedObject(_notificationMessageView, @"completionBlock");
        if (completionBlock) {
            completionBlock();
        }
        [_notificationMessageView removeFromSuperview];
        _notificationMessageView = nil;
    }];
}

- (void)handleNotificationViewPan:(UIPanGestureRecognizer *)recognizer {
    static CGFloat speed = 1;
    CGPoint point = [recognizer translationInView:_notificationMessageView.superview];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideNotificationMessageView) object:nil];
        _notificationViwePanned = 0;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        _notificationViwePanned += point.y * speed;
        CGFloat y = _notificationMessageView.y + point.y * speed;
        y = MIN(0, MAX(y, -_notificationMessageView.frame.size.height));
        _notificationMessageView.y = y;
        [recognizer setTranslation:CGPointZero inView:_notificationMessageView.superview];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (_notificationViwePanned > 0) {
            [self showNotificationMessageView];
        }
        else {
            [self hideNotificationMessageView];
        }
    }
}

// Alert Actions
- (void)showAlertMessageInViewController:(UIViewController *)viewController message:(NSString *)message {
    [self showAlertMessageInViewController:viewController
                                   message:message
                                 withTitle:nil];
}

- (void)showAlertMessageInViewController:(UIViewController *)viewController message:(NSString *)message withTitle:(NSString *)title {
    [self showAlertMessageInViewController:viewController
                                   message:message
                                 withTitle:title
                              onCompletion:nil];
}

- (void)showAlertMessageInViewController:(UIViewController *)viewController message:(NSString *)message onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [self showAlertMessageInViewController:viewController
                                   message:message
                                 withTitle:nil
                              onCompletion:completion];
}

- (void)showAlertMessageInViewController:(UIViewController *)viewController
                                 message:(NSString *)message
                               withTitle:(NSString *)title
                            onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [self showConfirmMessageInViewController:viewController
                                     message:message
                                   withTitle:title
                           cancelButtonTitle:kStr(@"Close")
                               okButtonTitle:nil
                                onCompletion:completion];
}

- (void)showConfirmMessageInViewController:(UIViewController *)viewController
                                   message:(NSString *)message
                                 withTitle:(NSString *)title
                              onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    [self showConfirmMessageInViewController:viewController
                                     message:message
                                   withTitle:title
                           cancelButtonTitle:kStr(@"Cancel")
                               okButtonTitle:kStr(@"Ok")
                                onCompletion:completion];
}

- (void)showConfirmMessageInViewController:(UIViewController *)viewController
                                   message:(NSString *)message
                                 withTitle:(NSString *)title
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                             okButtonTitle:(NSString *)okButtonTitle
                              onCompletion:(JHAlertControllerAlertCompletionBlock)completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlertController = alertController;
    NSInteger actionIndex = 0;
    if (![NSString isNullOrEmpty:cancelButtonTitle]) {
        [alertController addAction:[self alertActionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:completion index:actionIndex++ controller:weakAlertController]];
    }
    
    if (![NSString isNullOrEmpty:okButtonTitle]) {
        [alertController addAction:[self alertActionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:completion index:actionIndex++ controller:weakAlertController]];
    }
    
    UIViewController *vc = viewController;
    if (!vc) {
        vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    if (vc) {
        [vc presentViewController:alertController animated:YES completion:nil];
    }
}

// Action Sheet Actions
- (void)showActionSheetInViewController:(UIViewController *)viewController
                             completion:(JHAlertControllerActionSheetCompletionBlock)completion
                              withTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    NSMutableArray *otherButtonTitlesArray = [NSMutableArray array];
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString *)) {
        [otherButtonTitlesArray addObject:arg];
    }
    va_end(args);
    [self showActionSheetInViewController:viewController completion:completion
                                withTitle:title
                                  message:message
                        cancelButtonTitle:cancelButtonTitle
                   destructiveButtonTitle:destructiveButtonTitle
                 otherButtonTitlesInArray:otherButtonTitlesArray];
}

- (void)showActionSheetInViewController:(UIViewController *)viewController
                             completion:(JHAlertControllerActionSheetCompletionBlock)completion
                              withTitle:(NSString *)title
                                message:(NSString *)message
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitlesInArray:(NSArray *)otherButtonTitles {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    __weak UIAlertController *weakAlertController = alertController;
    NSInteger actionIndex = 0;
    if (![NSString isNullOrEmpty:cancelButtonTitle]) {
        [alertController addAction:[self alertActionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:completion index:actionIndex++ controller:weakAlertController]];
    }
    
    if (![NSString isNullOrEmpty:destructiveButtonTitle]) {
        [alertController addAction:[self alertActionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:completion index:actionIndex++ controller:weakAlertController]];
    }
    
    for (NSString *buttonTitle in otherButtonTitles) {
        if (![NSString isNullOrEmpty:buttonTitle]) {
            [alertController addAction:[self alertActionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:completion index:actionIndex++ controller:weakAlertController]];
        }
    }
    
    UIViewController *vc = viewController;
    if (!vc) {
        vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    if (vc) {
        [vc presentViewController:alertController animated:YES completion:nil];
    }
}

- (UIAlertAction *)alertActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(JHAlertControllerActionSheetCompletionBlock)handler index:(NSInteger)index controller:(UIAlertController *)controller {
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler(index, controller);
        }
    }];
    return alertAction;
}

@end

@implementation JHAlert (AlertView)

- (void) showAlertMessage:(NSString *)message {
    [self showAlertMessage:message withTitle:nil];
}

- (void) showAlertMessage:(NSString *)message withTitle:(NSString *)title{
    [self showAlertMessage:message withTitle:title onCompletion:nil];
}

- (void) showAlertMessage:(NSString *)message onCompletion:(JHAlertViewCompletionBlock)completion {
    [self showAlertMessage:message withTitle:nil onCompletion:completion];
}

- (void) showAlertMessage:(NSString*) message withTitle:(NSString *)title onCompletion:(JHAlertViewCompletionBlock)completion {
    [self showConfirmMessage:message withTitle:title cancelButtonTitle:kStr(@"Close") okButtonTitle:nil onCompletion:completion];
}

- (void) showConfirmMessage:(NSString *)message withTitle:(NSString *)title onCompletion:(JHAlertViewCompletionBlock)completion {
    [self showConfirmMessage:message withTitle:title cancelButtonTitle:kStr(@"Cancel") okButtonTitle:kStr(@"Ok") onCompletion:completion];
}

- (void) showConfirmMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle onCompletion:(JHAlertViewCompletionBlock)completion {
    
    if(!message || [NSString isNullOrEmpty:message]){
        return;
    }
    if(!_alertView){
        if ([NSString isNullOrEmpty:okButtonTitle]) {
            _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
        }
        else {
            _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: okButtonTitle, nil];
        }
        if (completion) {
            objc_setAssociatedObject(_alertView, &TW_ALERT_COMPLETION_BLOCK_KEY, completion, OBJC_ASSOCIATION_COPY);
        }
    }
    [_alertView show];
}

@end

@implementation JHAlert (ActionSheet)

- (void) showActionSheetInView:(UIView *)view
                    completion:(JHActionSheetCompletionBlock)completion
                     withTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (!_actionSheet) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle: nil destructiveButtonTitle:nil otherButtonTitles: nil];
        if (destructiveButtonTitle) {
            _actionSheet.destructiveButtonIndex = [_actionSheet addButtonWithTitle:destructiveButtonTitle];
        }
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [_actionSheet addButtonWithTitle:arg];
        }
        va_end(args);
        if (cancelButtonTitle) {
            _actionSheet.cancelButtonIndex = [_actionSheet addButtonWithTitle:cancelButtonTitle];
        }
        if (completion) {
            objc_setAssociatedObject(_actionSheet, &TW_ACTIONSHEET_COMPLETION_BLOCK_KEY, completion, OBJC_ASSOCIATION_COPY);
        }
    }
    [_actionSheet showInView:view];
}

- (void) showActionSheetInView:(UIView *)view
                    completion:(JHActionSheetCompletionBlock)completion
                     withTitle:(NSString *)title
             cancelButtonTitle:(NSString *)cancelButtonTitle
        destructiveButtonTitle:(NSString *)destructiveButtonTitle
      otherButtonTitlesInArray:(NSArray *)otherButtonTitles {
    if (!_actionSheet) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle: nil destructiveButtonTitle:nil otherButtonTitles: nil];
        if (destructiveButtonTitle) {
            _actionSheet.destructiveButtonIndex = [_actionSheet addButtonWithTitle:destructiveButtonTitle];
        }
        for (NSString *buttonTitle in otherButtonTitles) {
            [_actionSheet addButtonWithTitle:buttonTitle];
        }
        if (cancelButtonTitle) {
            _actionSheet.cancelButtonIndex = [_actionSheet addButtonWithTitle:cancelButtonTitle];
        }
        if (completion) {
            objc_setAssociatedObject(_actionSheet, &TW_ACTIONSHEET_COMPLETION_BLOCK_KEY, completion, OBJC_ASSOCIATION_COPY);
        }
    }
    [_actionSheet showInView:view];
}

@end

@implementation JHAlert (AlertDelegate)

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    JHAlertViewCompletionBlock completionBlock = objc_getAssociatedObject(alertView, &TW_ALERT_COMPLETION_BLOCK_KEY);
    if (completionBlock) {
        completionBlock(buttonIndex, alertView);
    }
    objc_removeAssociatedObjects(alertView);
    _alertView = nil;
}

@end

@implementation JHAlert (ActionSheetDelegate)

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    JHActionSheetCompletionBlock completionBlock = objc_getAssociatedObject(actionSheet, &TW_ACTIONSHEET_COMPLETION_BLOCK_KEY);
    if (completionBlock) {
        completionBlock(buttonIndex, actionSheet);
    }
    objc_removeAssociatedObjects(actionSheet);
    _actionSheet = nil;
}

@end

@implementation JHAlert (LoadingView)

- (void)showLoadingViewWithMessage:(NSString *)message inView:(UIView *)view {
    if (!_loadingView) {
        _loadingView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    _loadingView.mode = MBProgressHUDModeIndeterminate;
    _loadingView.label.text = message;
    _loadingView.removeFromSuperViewOnHide = YES;
}

- (void)removeLoadingView {
    if (_loadingView) {
        [_loadingView hideAnimated:YES];
        _loadingView = nil;
    }
}

@end
