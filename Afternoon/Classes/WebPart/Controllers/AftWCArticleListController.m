//
//  AftWCArticleListController.m
//  Afternoon
//
//  Created by Jaben on 16/1/31.
//  Copyright © 2016年 After. All rights reserved.
//

#import "AftWCArticleListController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>


@interface AftWCArticleListController ()

@end

@implementation AftWCArticleListController

- (void)viewDidLoad {
    [super viewDidLoad];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_web"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for(BmobObject *obj in array) {
            NSLog(@"============ 日期: %@============",obj.createdAt);
            NSLog(@"============ 标题：%@ ============", [obj objectForKey:@"title"]);
            NSLog(@"============ 内容：%@ ============", [obj objectForKey:@"previewContent"]);
            NSLog(@"============ 作者：%@ ============", [obj objectForKey:@"author"]);
            NSLog(@"============ URL：%@ ============", [obj objectForKey:@"url"]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
