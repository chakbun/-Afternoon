//
//  AftMainController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftMainController.h"
#import "AftAlbumController.h"
#import "AftMusicController.h"
#import "AftWCArticleListController.h"
#import "UIColor+JRColor.h"

@interface AftMainController ()<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *menuTabBar;

@end

@implementation AftMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = YES;
    NSArray *barItemTitles = @[@"照片",@"文章",@"音乐",@"吃点"];
    
    [self.menuTabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *obj, NSUInteger idx, BOOL *stop) {
        UIBarItem *barItem = obj;
        barItem.title = barItemTitles[idx];
    }];
    
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TabBarDelegate 

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[AftAlbumController class]]) {
        self.navigationController.title = @"照片";
    }else if([viewController isKindOfClass:[AftWCArticleListController class]]) {
        self.navigationController.title = @"文章";
    }else {
        self.navigationController.title = @"";
    }
}

@end
