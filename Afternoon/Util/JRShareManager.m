//
//  JRShareManager.m
//  Afternoon
//
//  Created by Jaben on 16/3/29.
//  Copyright © 2016年 After. All rights reserved.
//

#import "JRShareManager.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import "NSString+JRString.h"

#define kWeiboAccessToken   @"kWeiboAccessToken"
#define kWeiboUserID        @"kWeiboUserID"
#define kWeiboRefreshToken  @"kWeiboRefreshToken"


NSString *const kWeiBoAPP_KEY = @"1974935371";
NSString *const kWeiBoAPP_DIRECT_URL = @"http://www.sina.com";

NSString *const kWeChatAPP_KEY = @"wx4d51bfd07ea22bba";
NSString *const kWeChatAPP_SECRECT = @"755ddd68eb9f7365420ffe52e0a3b3c0";

@interface JRShareManager ()<WeiboSDKDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,WXApiDelegate>

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

#pragma mark - iMessage

- (BOOL)canSendMessage {
    return [MFMessageComposeViewController canSendText];
}

- (UIViewController *)messageControllerWithBody:(NSString *)body {
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    messageController.body = body;
    return messageController;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark - Mail

- (BOOL)canSendMail {
    return [MFMailComposeViewController canSendMail];
}

- (UIViewController *)mailControllerWithSubject:(NSString *)subject body:(NSString *)body image:(UIImage *)image{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:subject];
    [controller setMessageBody:body isHTML:YES];
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    [controller addAttachmentData:data mimeType:@"image/jpeg" fileName:@"image.jpg"];
    return controller;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    __weak __typeof(self) weakSelf = self;

    [controller dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.mailShareResultBlock) {
            weakSelf.mailShareResultBlock(result, error);
        }
    }];
}

#pragma mark - WeChat

- (void)initWeChatSetting {
    [WXApi registerApp:kWeChatAPP_KEY];
}

- (BOOL)canShareWeChatWithApp {
    return [WXApi isWXAppSupportApi];
}

- (void)shareToWeChatURL:(NSString *)webSite title:(NSString *)title description:(NSString *)des image:(UIImage *)image scene:(JRShareType)type completed:(void(^)(NSError *))completed {
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webSite;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = des;
    message.mediaObject = ext;
    message.mediaTagName = @"tagName";
    message.thumbData = UIImageJPEGRepresentation(image, 0.01);
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    
    if (type == JRShareTypeWechat) {
        req.scene = WXSceneSession;
    }else if(type == JRShareTypeWechatMoment) {
        req.scene = WXSceneTimeline;
    }
    req.message = message;

    [WXApi sendReq:req];
}

- (void)onReq:(BaseReq*)req {
    
}

- (void)onResp:(BaseResp*)resp {
    
}

#pragma mark - Weibo

- (BOOL)isWeiBoAuthorized {
    
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiboAccessToken];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiboUserID];
    NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:kWeiboRefreshToken];
    
    if (userToken && userID && refreshToken) {
        
        self.wbRefreshToken = refreshToken;
        self.wbUserID = userID;
        self.wbAccessToken = userToken;
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)canAuthorizedByWeibo {
    return [WeiboSDK isCanSSOInWeiboApp];
}

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

- (void)post2SinaWeibo:(NSString *)content image:(UIImage *)image imageURL:(NSString *)imageURL byApp:(BOOL)byApp completed:(void(^)(NSError *err))completed {

    
    if (byApp) {
        
        WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
        authRequest.redirectURI = kWeiBoAPP_DIRECT_URL;
        authRequest.scope = @"all";
        
        WBMessageObject *messageObj = [WBMessageObject message];
        
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = content;
        webpage.thumbnailData = UIImageJPEGRepresentation(image, 0.3);
        messageObj.mediaObject = webpage;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObj authInfo:authRequest access_token:self.wbAccessToken];
        [WeiboSDK sendRequest:request];
        
    }else {
        
        WBImageObject *imageObject = nil;
        
        if (image) {
            imageObject = [WBImageObject object];
            imageObject.imageData =  UIImageJPEGRepresentation(image, 0.3);
        }

        [WBHttpRequest requestForShareAStatus:content contatinsAPicture:imageObject orPictureUrl:imageURL withAccessToken:self.wbAccessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
            
            NSLog(@"============ err:%@ result:%@ ============",error, result);
            completed(error);
            
            
        }];
        
        
    }
    
    
}

- (BOOL)handlerURL:(NSURL *)url {

    if ([url.absoluteString isContainsMsg:kWeiBoAPP_KEY]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }else if([url.absoluteString isContainsMsg:kWeChatAPP_KEY]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else {
        return NO;
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {


}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSLog(@"============response %@ ============",response);
    
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        WBSendMessageToWeiboResponse *sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken){
            self.wbAccessToken = accessToken;
        }
        
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbUserID = userID;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kWeiboAccessToken];
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kWeiboUserID];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        self.wbAccessToken = [(WBAuthorizeResponse *)response accessToken];
        self.wbUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbAccessToken forKey:kWeiboAccessToken];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbUserID forKey:kWeiboUserID];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbRefreshToken forKey:kWeiboRefreshToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else if([response isKindOfClass:WBShareMessageToContactResponse.class]) {

        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
        if (accessToken) {
            self.wbAccessToken = accessToken;
        }
        
        NSString *userID = [shareMessageToContactResponse.authResponse userID];
        if (userID) {
            self.wbUserID = userID;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.wbAccessToken forKey:kWeiboAccessToken];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbUserID forKey:kWeiboUserID];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbRefreshToken forKey:kWeiboRefreshToken];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}

@end
