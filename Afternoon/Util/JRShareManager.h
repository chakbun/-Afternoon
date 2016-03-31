//
//  JRShareManager.h
//  Afternoon
//
//  Created by Jaben on 16/3/29.
//  Copyright © 2016年 After. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


static NSString *const kWeiBoAPP_KEY = @"1974935371";
static NSString *const kWeiBoAPP_DIRECT_URL = @"http://www.sina.com";

static NSString *const kWeChatAPP_KEY = @"wx4d51bfd07ea22bba";
static NSString *const kWeChatAPP_SECRECT = @"755ddd68eb9f7365420ffe52e0a3b3c0";

typedef NS_ENUM(NSInteger, JRShareType) {
    JRShareTypeWeibo = 1,
    JRShareTypeTencent = 2,
    JRShareTypeWechat = 3,
    JRShareTypeWechatMoment = 4,
};

@interface JRShareManager : NSObject

@property (nonatomic, strong) void(^mailShareResultBlock)(MFMailComposeResult result, NSError *error);

+ (instancetype)shareManager;

// weibo

- (void)initWeiboSetting;

- (void)authorizeWeibo;

- (BOOL)canAuthorizedByWeibo;

- (BOOL)handlerURL:(NSURL *)url type:(JRShareType)type;

- (BOOL)isWeiBoAuthorized;

- (void)post2SinaWeibo:(NSString *)content image:(UIImage *)image imageURL:(NSString *)imageURL byApp:(BOOL)byApp completed:(void(^)(NSError *err))completed;


//mail
- (BOOL)canSendMail;

- (UIViewController *)mailControllerWithSubject:(NSString *)subject body:(NSString *)body image:(UIImage *)image;

//message
- (BOOL)canSendMessage;

- (UIViewController *)messageControllerWithBody:(NSString *)body;

//WeChat

- (void)initWeChatSetting;

- (BOOL)canShareWeChatWithApp;

- (void)shareToWeChatURL:(NSString *)webSite title:(NSString *)title description:(NSString *)des image:(UIImage *)image scene:(JRShareType)type completed:(void(^)(NSError *))completed;

@end
