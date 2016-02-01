//
//  AftWCArticleListController.m
//  Afternoon
//
//  Created by Jaben on 16/1/31.
//  Copyright © 2016年 After. All rights reserved.
//

#import "AftWCArticleListController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import "AftWebViewController.h"
#import "AftWebModel.h"
#import "AftWCArticleCell.h"

@interface AftWCArticleListController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *articleTableview;

@property (nonatomic, strong) NSMutableArray *articleList;

@end

@implementation AftWCArticleListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.articleList = [NSMutableArray array];
    
    __weak __typeof(self) weakSelf = self;

    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_web"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for(BmobObject *obj in array) {
            NSLog(@"============ 日期: %@============",obj.createdAt);
            NSLog(@"============ 标题：%@ ============", [obj objectForKey:@"title"]);
            NSLog(@"============ 内容：%@ ============", [obj objectForKey:@"previewContent"]);
            NSLog(@"============ 作者：%@ ============", [obj objectForKey:@"author"]);
            NSLog(@"============ URL：%@ ============", [obj objectForKey:@"url"]);
            
            AftWebModel *webModel = [AftWebModel new];
            webModel.url = [obj objectForKey:@"url"];
            webModel.title = [obj objectForKey:@"title"];
            webModel.author = [obj objectForKey:@"author"];
            webModel.previewContent = [obj objectForKey:@"previewContent"];
            webModel.createDate = [obj objectForKey:@"createDate"];
            
            [weakSelf.articleList addObject:webModel];
            [weakSelf.articleTableview reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AftWebViewController *webViewController = [storyboard instantiateViewControllerWithIdentifier:@"AftWebViewController"];
    
    AftWebModel *webModel = self.articleList[indexPath.row];
    webViewController.webURL = webModel.url;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

#pragma mark - TabelView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AftWCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_AftWCArticleCell forIndexPath:indexPath];
    AftWebModel *webModel = self.articleList[indexPath.row];
    cell.articleTitleLabel.text = webModel.title;
    cell.articleDetailLabel.text = webModel.previewContent;
    return cell;
}

@end
