//
//  AftArticleController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftArticleController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>

@interface AftArticleController ()

@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;

@end

@implementation AftArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;

    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_article"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for(BmobObject *obj in array) {
            NSLog(@"============ 日期: %@============",obj.createdAt);
            NSLog(@"============ 标题：%@ ============", [obj objectForKey:@"title"]);
            NSLog(@"============ 内容：%@ ============", [obj objectForKey:@"content"]);
            NSLog(@"============ 作者：%@ ============", [obj objectForKey:@"author"]);
            NSLog(@"============ 简介:%@ ============",[obj objectForKey:@"authorInfo"]);
            NSLog(@"============ 来源:%@ ============",[obj objectForKey:@"refer"]);
        }
        BmobObject *obj = array[array.count - 1];
        [weakSelf.articleWebView loadHTMLString:[obj objectForKey:@"content"] baseURL:nil];
    }];
}

- (NSString *)parseTheRawString:(NSString *)rawString {
    /*
     @"&nbsp" = @"";
     <p></p>
     */
    NSString *stringRemove_nbsp = [rawString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    NSString *stringInSection = [stringRemove_nbsp stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    NSString *stringRemoveHead = [stringInSection stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    return stringRemoveHead;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
