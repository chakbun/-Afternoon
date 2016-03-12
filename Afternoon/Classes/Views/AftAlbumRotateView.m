//
//  AftAblumRotateView.m
//  Afternoon
//
//  Created by Jaben on 15/11/3.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftAlbumRotateView.h"
#import "Masonry.h"

@interface AftAlbumRotateView ()
@property (nonatomic, strong) UIImageView *ablumImageView;
@property (nonatomic, strong) UIImageView *buttonImageView;
@end

@implementation AftAlbumRotateView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWidget];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWidget];
    }
    return self;
}

- (void)initWidget {

    
    __weak __typeof(self) weakSelf = self;

    self.ablumImageView = [UIImageView new];
    [self.ablumImageView setImage:[UIImage imageNamed:@"avatar"]];
    self.ablumImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.ablumImageView];
    
    [self.ablumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIImage *stateImage = [UIImage imageNamed:@"start"];
    self.buttonImageView = [UIImageView new];
    [self.buttonImageView setImage:stateImage];
    [self addSubview:self.buttonImageView];

    [self.buttonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(stateImage.size.width));
        make.height.equalTo(@(stateImage.size.height));
        make.center.equalTo(weakSelf.ablumImageView);
    }];
    
}
@end
