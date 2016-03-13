//
//  AftAlbumTableHeadView.h
//  Afternoon
//
//  Created by Jaben on 16/3/12.
//  Copyright © 2016年 After. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AftAlbumTableHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *themeLabel;

@property (weak, nonatomic) IBOutlet UITextView *detailLabel;


- (void)setTheme:(NSString *)theme;

- (void)setDetail:(NSString *)detail;

@end
