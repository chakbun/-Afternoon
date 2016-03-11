//
//  AftImageAblumController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftImageAblumController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import "UIImageView+WebCache.h"

@interface AftImageAblumController ()

@end

@implementation AftImageAblumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;

    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_album"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for(BmobObject *obj in array) {
            NSLog(@"============ 日期: %@============",obj.createdAt);
            NSLog(@"============ 图片：%@ ============", [obj objectForKey:@"originImage"]);
            NSLog(@"============ 作者：%@ ============", [obj objectForKey:@"author"]);
            NSLog(@"============ 宽度：%@ ============", [obj objectForKey:@"width"]);
            NSLog(@"============ 高度:%@ ============",[obj objectForKey:@"height"]);
        }
        BmobObject *obj = array[array.count - 1];
        BmobFile *imageFile = [obj objectForKey:@"originImage"];
        NSLog(@"============ imageUrl :%@ ============",imageFile.url);

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
