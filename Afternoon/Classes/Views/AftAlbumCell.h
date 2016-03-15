//
//  AftAlbumCell.h
//  Afternoon
//
//  Created by Jaben on 16/3/11.
//  Copyright © 2016年 After. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_ID_ABLUM @"AftAlbumCellID"

@interface AftAlbumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;

@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *introLabelHeightConstraint;

@property (nonatomic, strong) void (^didImageTapBlock)(UIImageView *imageView);

@end
