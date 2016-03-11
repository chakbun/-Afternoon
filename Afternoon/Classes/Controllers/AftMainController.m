//
//  AftMainController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftMainController.h"
#import "AftImageAblumController.h"
#import "AftMusicController.h"
#import "UIColor+JRColor.h"

@interface AftMainController ()

@property (weak, nonatomic) IBOutlet UITabBar *menuTabBar;

@end

@implementation AftMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor themeGreyGreen];

    self.navigationController.navigationBar.translucent = YES;
    NSArray *barItemTitles = @[@"照片",@"文章",@"音乐",@"吃点"];
    
    [self.menuTabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *obj, NSUInteger idx, BOOL *stop) {
        UIBarItem *barItem = obj;
        barItem.title = barItemTitles[idx];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
