//
//  JRPhotoViewer.m
//  Afternoon
//
//  Created by Jaben on 16/3/15.
//  Copyright © 2016年 After. All rights reserved.
//

#import "JRPhotoViewer.h"

@interface JRPhotoViewer ()<UIScrollViewDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;

@end

@implementation JRPhotoViewer

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.mainScrollView.delegate = self;
        self.mainScrollView.minimumZoomScale = 1.0;
        self.mainScrollView.maximumZoomScale = 10;
        self.mainScrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95];
        [self addSubview:self.mainScrollView];
        
        self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDoubleTapAction:)];
        self.doubleTapGesture.numberOfTapsRequired = 2;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewerTapAction:)];
        [tapGesture requireGestureRecognizerToFail:self.doubleTapGesture];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setImageView:(UIImageView *)imageView {
    _imageView = imageView;
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:self.doubleTapGesture];
    [self.mainScrollView addSubview:_imageView];
}

#pragma mark - Gesture

- (void)viewerTapAction:(UITapGestureRecognizer *)gesture {
    
    [self showPhotoViewer:NO];
}

- (void)imageViewDoubleTapAction:(UITapGestureRecognizer *)gesture {
    
    __weak __typeof(self) weakSelf = self;
    
    CGPoint touchPoint = [gesture locationInView:weakSelf.imageView];
    CGFloat touchPart = touchPoint.x / self.imageView.frame.size.width;
    NSInteger showPart = 0;
    if (touchPart < 1/3.0) {
        showPart = -1;
    }else if(touchPart > 2/3.0) {
        showPart = 1;
    }

    [UIView animateWithDuration:0.4 animations:^{
        
        if (weakSelf.mainScrollView.zoomScale > 1.0) {
            weakSelf.mainScrollView.zoomScale = 1.0;
        }else {
            weakSelf.mainScrollView.zoomScale = 2.0;
            
            CGFloat y = (weakSelf.imageView.frame.size.height - weakSelf.frame.size.height) / 2.0;
            if (showPart == -1) {
                weakSelf.mainScrollView.contentOffset = CGPointMake(0, y);
            }else if(showPart == 1) {
                weakSelf.mainScrollView.contentOffset = CGPointMake(weakSelf.imageView.frame.size.width - weakSelf.frame.size.width, y);
            }
        }
    }];
}

#pragma mark - Private

- (void)showPhotoViewer:(BOOL)show {
    
    __weak __typeof(self) weakSelf = self;
    
    if (show) {
        CGFloat showHeight = [[UIScreen mainScreen] bounds].size.width * self.tapRect.size.height / self.tapRect.size.width;
        
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.imageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, showHeight);
            weakSelf.imageView.center = weakSelf.center;
            weakSelf.alpha = 1.0;
        }];
    }else {
        
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.imageView.frame = weakSelf.tapRect;
            weakSelf.alpha = 0.0;
        } completion:^(BOOL finished) {
            weakSelf.mainScrollView.zoomScale = 1.0;
        }];
        
    }
}

#pragma mark - ScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = self.imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }
    
    self.imageView.center = centerPoint;
}

@end
