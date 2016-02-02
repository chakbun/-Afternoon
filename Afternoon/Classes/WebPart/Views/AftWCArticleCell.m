//
//  AftWCArticleCell.m
//  Afternoon
//
//  Created by cloudtech on 2/1/16.
//  Copyright © 2016 After. All rights reserved.
//

#import "AftWCArticleCell.h"


@interface AftWCArticleCell ()

@end

@implementation AftWCArticleCell

- (void)awakeFromNib {
    self.artImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
