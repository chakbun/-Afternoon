//
//  JRShareManager.h
//  Afternoon
//
//  Created by Jaben on 16/3/29.
//  Copyright © 2016年 After. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JRShareType) {
    JRShareTypeWeibo = 1,
    JRShareTypeTencent = 2,
    JRShareTypeWechat = 3,
};

@interface JRShareManager : NSObject

+ (instancetype)shareManager;

- (void)initWeiboSetting;

- (void)authorizeWeibo;

- (BOOL)handlerURL:(NSURL *)url type:(JRShareType)type;

- (void)shareMessage:(NSString *)message;

- (BOOL)isWeiBoAuthorized;

@end
