//
//  AftWCArticleCell.h
//  Afternoon
//
//  Created by cloudtech on 2/1/16.
//  Copyright © 2016 After. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_ID_AftWCArticleCell @"AftWCArticleCell"

@interface AftWCArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *articleDetailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *artImageView;

@property (weak, nonatomic) IBOutlet UILabel *preContentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *preContentLabelHeightConstraint;

@end
