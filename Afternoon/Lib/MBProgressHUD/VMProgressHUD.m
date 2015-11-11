//
//  VMProgressHUD.m
//  VMark
//
//  Created by __无邪_ on 15/3/26.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "VMProgressHUD.h"

@implementation VMProgressHUD

+ (instancetype)sharedInstance{
    static VMProgressHUD *progressView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        progressView = [[VMProgressHUD alloc] init];
    });
    return progressView;
}


- (void)hide{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.HUD hide:YES];
    });
}

- (void)hideAfterDealy:(NSTimeInterval)dealy{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD hide:YES afterDelay:dealy];
    });
}

- (void)showOnlyProgress{// 带有菊花的
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD show:YES];
        [_HUD hide:YES afterDelay:50];
    });
}

- (void)showProgressDismissAfter:(NSTimeInterval)dealy{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD show:YES];
        [_HUD hide:YES afterDelay:dealy];
    });
}

- (void)showProgressWithText:(NSString *)text{
    [self showProgressWithText:text dealy:60];
}

- (void)showProgressWithTextAutoDismiss:(NSString *)text{
    [self showProgressWithText:text dealy:1.2];
}

- (void)showProgressWithText:(NSString *)text dealy:(NSTimeInterval)dealy{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD setMode:MBProgressHUDModeIndeterminate];
        NSString *fixText = text?:@"";
        _HUD.detailsLabelText = fixText;
        _HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        [_HUD show:YES];
        [_HUD hide:YES afterDelay:dealy];
    });
}

- (void)showProgressWithText:(NSString *)text dealy:(NSTimeInterval)dealy timeoutText:(NSString *)timeoutText{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD setMode:MBProgressHUDModeIndeterminate];
        NSString *fixText = text?:@"";
        _HUD.detailsLabelText = fixText;
        _HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        [_HUD show:YES];
        [self hideAfterDelay:dealy withTimeout:timeoutText];
    });
}

- (void)showTipTextOnlyAutoHide:(NSString *)text{
    [self showTipTextOnly:text dealy:1.0];
}

- (void)showTipTextOnly:(NSString *)text{
    [self showTipTextOnly:text dealy:40];
}


- (void)showTipTextOnly:(NSString *)text dealy:(NSTimeInterval)dealy{ //只有文字的
    dispatch_async(dispatch_get_main_queue(), ^{
        self.HUD.mode = MBProgressHUDModeText;
        
        NSString *fixText = text?:@"";
        _HUD.detailsLabelText = fixText;
        _HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        [_HUD show:YES];
        [_HUD hide:YES afterDelay:dealy];
    });
}



-(MBProgressHUD *)HUD{
    [_HUD removeFromSuperview];
    _HUD = nil;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    _HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:_HUD];
    _HUD.delegate = nil;
    _HUD.margin = 10.f;
    _HUD.dimBackground = NO;
    _HUD.removeFromSuperViewOnHide = YES;
    
    return _HUD;
}




- (void)showTipWithAutoDismiss:(NSString *)text{ //自定义view
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    UILabel *backg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 80)];
    if(text.length > 25) {
        CGRect rect = backg.frame;
        rect.size.height = rect.size.height * 1.5;
        backg.frame = rect;
        backg.numberOfLines =2;
    }
    
    backg.backgroundColor = [UIColor whiteColor];
    backg.textAlignment = NSTextAlignmentCenter;
    backg.textColor = [UIColor darkGrayColor];
    backg.layer.cornerRadius = 10;
    backg.layer.masksToBounds = YES;
    
    NSString *fixText = text?:@"";
    backg.text = fixText;
    
    hud.margin = 0.f;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = backg;
    hud.dimBackground = NO;
    hud.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.210];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.4];
    
}


- (void)hideAfterDelay:(NSTimeInterval)delay withTimeout:(NSString *)text{
    [self performSelector:@selector(hideDelayedWithTimeout:) withObject:text afterDelay:delay];
}

- (void)hideDelayedWithTimeout:(NSString *)text{
    [_HUD hide:YES];
    [self showProgressWithText:text dealy:1.2];
}



- (void)showInView:(UIView *)superView text:(NSString *)text afterDealy:(NSTimeInterval)dealy{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_HUD removeFromSuperview];
        _HUD = nil;
        
        _HUD = [[MBProgressHUD alloc] initWithView:superView];
        _HUD.delegate = nil;
        _HUD.margin = 10.f;
        _HUD.dimBackground = NO;
        _HUD.removeFromSuperViewOnHide = YES;
        _HUD.mode = MBProgressHUDModeIndeterminate;
        [superView addSubview:_HUD];
        [superView bringSubviewToFront:_HUD];
        NSString *fixText = text?:@"";
        _HUD.detailsLabelText = fixText;
        _HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        [_HUD show:YES];
        [_HUD hide:YES afterDelay:dealy];
    });
    
}



@end
