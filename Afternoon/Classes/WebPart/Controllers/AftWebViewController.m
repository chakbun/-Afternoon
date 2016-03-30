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

    
    __weak __typeof(self) weakSelf = self;

    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    NSString *shareText = [NSString stringWithFormat:@"午后:%@ %@",self.webModel.previewContent,self.webModel.url];
    
    UIAlertAction *weiboAction = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if ([[JRShareManager shareManager] isWeiBoAuthorized]) {
            
            [[JRShareManager shareManager] post2SinaWeibo:shareText image:weakSelf.coverImage imageURL:nil byApp:NO completed:^(NSError *err) {
                
            }];
            
        }else {
            [[JRShareManager shareManager] authorizeWeibo];
        }
        
    }];
    
    UIAlertAction *weChatMomentsAction = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }];
    
    UIAlertAction *weChatFriendAction = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }];
    
    UIAlertAction *iMessageAction = [UIAlertAction actionWithTitle:@"iMessage" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }];
    
    UIAlertAction *emailAction = [UIAlertAction actionWithTitle:@"邮件" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if([[JRShareManager shareManager] canSendMail]) {
            
            NSString *linkText = [NSString stringWithFormat:@"午后:%@ <a>%@</a>",weakSelf.webModel.previewContent,weakSelf.webModel.url];

            [[JRShareManager shareManager] setMailShareResultBlock:^(MFMailComposeResult result, NSError *error) {
                
                
                
            }];
            
            UIViewController *mailController = [[JRShareManager shareManager] mailControllerWithSubject:@"来自午后Afternoon的分享" body:linkText image:weakSelf.coverImage];
            [weakSelf presentViewController:mailController animated:YES completion:nil];
            
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertViewController addAction:weiboAction];
    [alertViewController addAction:emailAction];
    [alertViewController addAction:cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}


@end
