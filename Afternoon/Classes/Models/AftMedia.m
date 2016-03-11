//
//  AftMedia.m
//  Afternoon
//
//  Created by Jaben on 15/11/13.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftMedia.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AftMedia

- (instancetype)mediaWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *mediaName = [dateFormatter stringFromDate:date];
    return [AftMedia MR_findFirstByAttribute:@"fileName" withValue:mediaName];
}

@end
