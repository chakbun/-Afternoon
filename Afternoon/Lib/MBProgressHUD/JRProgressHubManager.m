//
//  JRProgressHubManager.m
//  Afternoon
//
//  Created by Jaben on 15/11/11.
//  Copyright © 2015年 After. All rights reserved.
//

#import "JRProgressHubManager.h"
#import "MBProgressHUD.h"

@interface JRProgressHubManager ()

@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation JRProgressHubManager

+ (instancetype)shareManager {
    static JRProgressHubManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[[JRProgressHubManager alloc] init];
        
    });
    return shareManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (MBProgressHUD *)HUD{
    
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

#pragma mark - Public

- (void)showProgressWithText:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD setMode:MBProgressHUDModeIndeterminate];
        NSString *fixText = text?:@"";
        _HUD.detailsLabelText = fixText;
        _HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        [_HUD show:YES];
    });
}

- (void)hiddenProgressView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.HUD hide:YES];
    });
}

@end
