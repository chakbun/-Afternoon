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

typedef NS_ENUM(NSInteger, JRShareType) {
    JRShareTypeWeibo = 1,
    JRShareTypeTencent = 2,
    JRShareTypeWechat = 3,
};

@interface JRShareManager : NSObject

@property (nonatomic, strong) void(^mailShareResultBlock)(MFMailComposeResult result, NSError *error);

+ (instancetype)shareManager;

// weibo

- (void)initWeiboSetting;

- (void)authorizeWeibo;

- (BOOL)handlerURL:(NSURL *)url type:(JRShareType)type;

- (BOOL)isWeiBoAuthorized;

- (void)post2SinaWeibo:(NSString *)content image:(UIImage *)image imageURL:(NSString *)imageURL byApp:(BOOL)byApp completed:(void(^)(NSError *err))completed;


//mail
- (BOOL)canSendMail;

- (UIViewController *)mailControllerWithSubject:(NSString *)subject body:(NSString *)body image:(UIImage *)image;

@end
