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
    
    if (self.webModel) {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webModel.url]];
        [self.contentWebView loadRequest:urlRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action

- (void)shareButtonAction:(id)sender {
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    __weak __typeof(self) weakSelf = self;

    UIAlertAction *weiboAction = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([[JRShareManager shareManager] isWeiBoAuthorized]) {
            
            [[JRShareManager shareManager] shareMessage:weakSelf.webModel.previewContent];
            
        }else {
            [[JRShareManager shareManager] authorizeWeibo];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertViewController addAction:weiboAction];
    [alertViewController addAction:cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}


@end
