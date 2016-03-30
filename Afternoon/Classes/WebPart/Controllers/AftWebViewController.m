//
//  AftWebViewController.m
//  Afternoon
//
//  Created by Jaben on 16/1/31.
//  Copyright © 2016年 After. All rights reserved.
//

#import "AftWebViewController.h"
#import "JRShareManager.h"

@interface AftWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation AftWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareButtonAction:)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    if (self.webURL) {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]];
        [self.contentWebView loadRequest:urlRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action

- (void)shareButtonAction:(id)sender {
    
    [[JRShareManager shareManager] authorizeWeibo];
//    [[JRShareManager shareManager] shareMessage:@"xxx"];
    
}


@end
