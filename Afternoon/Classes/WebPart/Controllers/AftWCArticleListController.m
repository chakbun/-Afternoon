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
    [bquery orderByDescending:@"createDate"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for(BmobObject *bmobObj in array) {
            NSLog(@"============ 日期: %@============",bmobObj.createdAt);
            NSLog(@"============ 标题：%@ ============", [bmobObj objectForKey:@"title"]);
            NSLog(@"============ 内容：%@ ============", [bmobObj objectForKey:@"previewContent"]);
            NSLog(@"============ 作者：%@ ============", [bmobObj objectForKey:@"author"]);
            NSLog(@"============ URL：%@ ============", [bmobObj objectForKey:@"url"]);
            
            BmobFile *fileInfo = [bmobObj objectForKey:@"previewImage"];
            
            AftWebModel *webModel = [AftWebModel new];
            webModel.url = [bmobObj objectForKey:@"url"];
            webModel.title = [bmobObj objectForKey:@"title"];
            webModel.author = [bmobObj objectForKey:@"author"];
            webModel.previewContent = [bmobObj objectForKey:@"previewContent"];
            webModel.createDate = [bmobObj objectForKey:@"createDate"];
            webModel.previewImage = fileInfo.url;
            
            [weakSelf.articleList addObject:webModel];
        }
//        [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            
//            BmobObject *bmobObj = obj;
//            
//            NSLog(@"============ 日期: %@============",bmobObj.createdAt);
//            NSLog(@"============ 标题：%@ ============", [bmobObj objectForKey:@"title"]);
//            NSLog(@"============ 内容：%@ ============", [bmobObj objectForKey:@"previewContent"]);
//            NSLog(@"============ 作者：%@ ============", [bmobObj objectForKey:@"author"]);
//            NSLog(@"============ URL：%@ ============", [bmobObj objectForKey:@"url"]);
//            
//            BmobFile *fileInfo = [bmobObj objectForKey:@"previewImage"];
//            
//            AftWebModel *webModel = [AftWebModel new];
//            webModel.url = [bmobObj objectForKey:@"url"];
//            webModel.title = [bmobObj objectForKey:@"title"];
//            webModel.author = [bmobObj objectForKey:@"author"];
//            webModel.previewContent = [bmobObj objectForKey:@"previewContent"];
//            webModel.createDate = [bmobObj objectForKey:@"createDate"];
//            webModel.previewImage = fileInfo.url;
//            
//            [weakSelf.articleList addObject:webModel];
//        }];
        
        [weakSelf.articleTableview reloadData];

    }];
    
    //init formatter
    self.yyyyMMddFormatter = [NSDateFormatter new];
    self.yyyyMMddFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.articleTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    return 287;
}

#pragma mark - TabelView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AftWCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_AftWCArticleCell forIndexPath:indexPath];
    AftWebModel *webModel = self.articleList[indexPath.row];
    
    cell.articleTitleLabel.text = webModel.title;
    cell.articleDetailLabel.text = [self.yyyyMMddFormatter stringFromDate:webModel.createDate];
    cell.preContentLabel.text = webModel.previewContent;
    [cell.artImageView sd_setImageWithURL:[NSURL URLWithString:webModel.previewImage] placeholderImage:[UIImage imageNamed:@"google"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
