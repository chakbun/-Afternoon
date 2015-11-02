//
//  AftMainController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftMainController.h"
#import "AftArticleController.h"
#import "AftImageAblumController.h"
#import "AftMusicController.h"

@interface AftMainController ()

@property (weak, nonatomic) IBOutlet UITabBar *menuTabBar;

@end

@implementation AftMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *barItemTitles = @[@"照片",@"文章",@"音乐",@"吃点"];
    
    [self.menuTabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBarItem *barItem = obj;
        barItem.title = barItemTitles[idx];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
