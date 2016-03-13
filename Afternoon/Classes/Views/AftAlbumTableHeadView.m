//
//  AftAlbumTableHeadView.m
//  Afternoon
//
//  Created by Jaben on 16/3/12.
//  Copyright © 2016年 After. All rights reserved.
//

#import "AftAlbumTableHeadView.h"

@implementation AftAlbumTableHeadView

- (void)awakeFromNib {
    self.detailLabel.contentInset = UIEdgeInsetsMake(5.0f, 20.0f, 5.0f, 0.f);
}

- (void)setTheme:(NSString *)theme {
    self.themeLabel.text = [NSString stringWithFormat:@"%@",theme];
}

- (void)setDetail:(NSString *)detail {
    self.detailLabel.text = detail;
}

@end
