//
//  ViewController.m
//  Afternoon
//
//  Created by Jaben on 15/10/24.
//  Copyright © 2015年 After. All rights reserved.
//

#import "ViewController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_music"];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        for(BmobObject *obj in array) {
//            NSLog(@"============ 日期: %@============",obj.createdAt);
//            NSLog(@"============ 歌名：%@ ============", [obj objectForKey:@"title"]);
//            NSLog(@"============ 歌手：%@ ============", [obj objectForKey:@"singer"]);
//            NSLog(@"============ 内容：%@ ============", [obj objectForKey:@"originMusic"]);
//            NSLog(@"============ 专辑:%@ ============",[obj objectForKey:@"musicAlbum"]);
//            
//        }
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)imageButtonAction:(id)sender {
    
}

- (IBAction)articleButtonAction:(id)sender {
    
}

- (IBAction)musicButtonAction:(id)sender {
    
}

@end
