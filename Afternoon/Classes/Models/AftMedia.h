//
//  AftMedia.h
//  Afternoon
//
//  Created by Jaben on 15/11/13.
//  Copyright © 2015年 After. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AftMedia : NSManagedObject

- (instancetype)mediaWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END

#import "AftMedia+CoreDataProperties.h"
