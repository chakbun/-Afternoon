//
//  AftAlbumCell.m
//  Afternoon
//
//  Created by Jaben on 16/3/11.
//  Copyright © 2016年 After. All rights reserved.
//

#import "AftAlbumCell.h"

@implementation AftAlbumCell

- (void)awakeFromNib {
    
    self.albumImageView.clipsToBounds = YES;
    self.introLabel.numberOfLines = 0;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapGesture:)];
    [self.albumImageView addGestureRecognizer:tapGesture];
}

- (void)imageViewTapGesture:(UITapGestureRecognizer *)gesture {
    
    if (self.didImageTapBlock) {
        self.didImageTapBlock(self.albumImageView);
    }
}

@end
