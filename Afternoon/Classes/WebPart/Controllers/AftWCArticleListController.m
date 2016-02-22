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
#import "UIImageView+WebCache.h"

@interface AftWCArticleListController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *articleTableview;

@property (nonatomic, strong) NSMutableArray *articleList;

@property (nonatomic, strong) NSDateFormatter *yyyyMMddFormatter;

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
            
            BmobFile *fileInfo = [obj objectForKey:@"previewImage"];
            
            AftWebModel *webModel = [AftWebModel new];
            webModel.url = [obj objectForKey:@"url"];
            webModel.title = [obj objectForKey:@"title"];
            webModel.author = [obj objectForKey:@"author"];
            webModel.previewContent = [obj objectForKey:@"previewContent"];
            webModel.createDate = [obj objectForKey:@"createDate"];
            webModel.previewImage = fileInfo.url;
            
            [weakSelf.articleList addObject:webModel];
            [weakSelf.articleTableview reloadData];
        }
    }];
    
    //init formatter
    self.yyyyMMddFormatter = [NSDateFormatter new];
    self.yyyyMMddFormatter.dateFormat = @"yyyy-MM-dd";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"article2WebSegue"]) {
        
        AftWebViewController *webViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.articleTableview indexPathForCell:sender];
        AftWebModel *webModel = self.articleList[indexPath.row];
        webViewController.webURL = webModel.url;
    }
}

#pragma mark - TabelView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

#pragma mark - TabelView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AftWCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_AftWCArticleCell forIndexPath:indexPath];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else {
        cell.backgroundColor = [UIColor greenColor];
    }
    AftWebModel *webModel = self.articleList[indexPath.row];
    
    cell.articleTitleLabel.text = webModel.title;
    cell.articleDetailLabel.text = [self.yyyyMMddFormatter stringFromDate:webModel.createDate];
    [cell.artImageView sd_setImageWithURL:[NSURL URLWithString:webModel.previewImage] placeholderImage:[UIImage imageNamed:@"google"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
