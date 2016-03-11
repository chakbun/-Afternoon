//
//  AftImageAblumController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftAlbumController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import "UIImageView+WebCache.h"
#import "AftAlbum.h"
#import "AftAlbumCell.h"
#import "AppConstants.h"

@interface AftAlbumController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *albumTableView;

@property (nonatomic, strong) NSMutableArray *albumArray;

@property (nonatomic, strong) NSMutableDictionary *cellHeightDictionary;

@end

@implementation AftAlbumController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.albumArray = [NSMutableArray array];
    self.cellHeightDictionary = [NSMutableDictionary dictionary];
    
    __weak __typeof(self) weakSelf = self;

    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_album"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        for(BmobObject *obj in array) {
            
            AftAlbum *album = [AftAlbum new];

            BmobFile *imageFile = [obj objectForKey:@"originImage"];

            album.imageURL = imageFile.url;
            album.author = [obj objectForKey:@"author"];
            album.title = [obj objectForKey:@"title"];
            album.intro = [obj objectForKey:@"intro"];
            
            [weakSelf.albumArray addObject:album];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [weakSelf.albumTableView reloadData];
        });
    }];
    
    self.albumTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.albumTableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)keyFromIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"key_%i_%i",(int)indexPath.section,(int)indexPath.row];
}

#pragma mark - TabelView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *heightNumber = self.cellHeightDictionary[[self keyFromIndexPath:indexPath]];
    if (heightNumber) {
        return [heightNumber floatValue];
    }
    return 180;
}

#pragma mark - TabelView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AftAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID_ABLUM forIndexPath:indexPath];
    
    AftAlbum *album = self.albumArray[indexPath.row];
    

    __weak __typeof(self) weakSelf = self;

    [cell.albumImageView sd_setImageWithURL:[NSURL URLWithString:album.imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!weakSelf.cellHeightDictionary[[weakSelf keyFromIndexPath:indexPath]]) {
            
            CGFloat showHeight = (SCREEN_WIDTH - (MARGINS * 2)) * image.size.height / image.size.width;
            CGFloat cellHeight = MARGINS + 22 + MARGINS + 16 + MARGINS + showHeight;
            weakSelf.cellHeightDictionary[[weakSelf keyFromIndexPath:indexPath]] = @(cellHeight);
            [weakSelf.albumTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }];
    
    cell.albumTitleLabel.text = album.title;
    cell.introLabel.text = album.intro;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
