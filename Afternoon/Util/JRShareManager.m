//
//  JRShareManager.m
//  Afternoon
//
//  Created by Jaben on 16/3/29.
//  Copyright © 2016年 After. All rights reserved.
//

#import "JRShareManager.h"
#import "WeiboSDK.h"

NSString *const kWeiBoAPP_KEY = @"1974935371";
NSString *const kWeiBoAPP_DIRECT_URL = @"http://www.sina.com";

@interface JRShareManager ()<WeiboSDKDelegate>

@property (nonatomic, strong) NSString *wbAccessToken;
@property (nonatomic, strong) NSString *wbUserID;
@property (nonatomic, strong) NSString *wbRefreshToken;
@end

@implementation JRShareManager

+ (instancetype)shareManager {
    static JRShareManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[[JRShareManager alloc] init];
        
    });
    
    return shareManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Weibo

- (void)initWeiboSetting {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kWeiBoAPP_KEY];
}

- (void)authorizeWeibo {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiBoAPP_DIRECT_URL;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (void)shareMessage:(NSString *)message {
    
    WBMessageObject *messageObject = [WBMessageObject message];
    messageObject.text = message;
    
    WBProvideMessageForWeiboResponse *response = [WBProvideMessageForWeiboResponse responseWithMessage:messageObject];
    [WeiboSDK sendResponse:response];
}

- (BOOL)handlerURL:(NSURL *)url type:(JRShareType)type {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    NSLog(@"============request %@ ============",request);

}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSLog(@"============response %@ ============",response);
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbAccessToken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.wbAccessToken = [(WBAuthorizeResponse *)response accessToken];
        self.wbUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [alert show];
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
    {
        NSString *title = NSLocalizedString(@"邀请结果", nil);
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }else if([response isKindOfClass:WBShareMessageToContactResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbAccessToken = accessToken;
        }
        NSString* userID = [shareMessageToContactResponse.authResponse userID];
        if (userID) {
            self.wbUserID = userID;
        }
        [alert show];
    }
}

@end
