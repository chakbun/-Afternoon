//
//  JRPhotoViewer.h
//  Afternoon
//
//  Created by Jaben on 16/3/15.
//  Copyright © 2016年 After. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRPhotoViewer : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, assign) CGRect tapRect;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)showPhotoViewer:(BOOL)show;

@end
