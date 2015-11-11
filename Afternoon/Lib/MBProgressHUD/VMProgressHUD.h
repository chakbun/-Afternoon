//
//  VMProgressHUD.h
//  VMark
//
//  Created by __无邪_ on 15/3/26.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface VMProgressHUD : NSObject
@property (nonatomic, strong)MBProgressHUD *HUD;


+ (instancetype)sharedInstance;

- (void)showTipWithAutoDismiss:(NSString *)text;

- (void)showProgress;//带有菊花的
- (void)showProgressDismissAfter:(NSTimeInterval)dealy;

- (void)showProgressWithText:(NSString *)text;
- (void)showProgressWithTextAutoDismiss:(NSString *)text;

- (void)showProgressWithText:(NSString *)text dealy:(NSTimeInterval)dealy;
- (void)showProgressWithText:(NSString *)text dealy:(NSTimeInterval)dealy timeoutText:(NSString *)timeoutText;

- (void)showTipTextOnly:(NSString *)text;//只有文字的
- (void)showTipTextOnlyAutoHide:(NSString *)text;//1.2秒后自动隐藏的
- (void)showTipTextOnly:(NSString *)text dealy:(NSTimeInterval)dealy;
- (void)showInView:(UIView *)superView text:(NSString *)text afterDealy:(NSTimeInterval)dealy;

- (void)hide;
- (void)hideAfterDealy:(NSTimeInterval)dealy;

@end
