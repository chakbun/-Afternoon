//
//  JRProgressHubManager.h
//  Afternoon
//
//  Created by Jaben on 15/11/11.
//  Copyright © 2015年 After. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRProgressHubManager : NSObject

+ (instancetype)shareManager;

- (void)showProgressWithText:(NSString *)text;

- (void)hiddenProgressView;

@end
