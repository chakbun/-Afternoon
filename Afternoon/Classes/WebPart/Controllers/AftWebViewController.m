//
//  AftWebViewController.m
//  Afternoon
//
//  Created by Jaben on 16/1/31.
//  Copyright © 2016年 After. All rights reserved.
//

#import "AftWebViewController.h"

@interface AftWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation AftWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.webURL) {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]];
        [self.contentWebView loadRequest:urlRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
