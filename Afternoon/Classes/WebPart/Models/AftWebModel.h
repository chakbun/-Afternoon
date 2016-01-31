//
//  AftWebModel.h
//  Afternoon
//
//  Created by Jaben on 16/1/31.
//  Copyright © 2016年 After. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AftWebModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *previewContent;
@property (nonatomic, strong) NSString *previewImage;
@property (nonatomic, strong) NSDate *createDate;

@end

