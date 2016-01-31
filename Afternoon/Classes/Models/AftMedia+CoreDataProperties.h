//
//  AftMedia+CoreDataProperties.h
//  Afternoon
//
//  Created by Jaben on 15/11/13.
//  Copyright © 2015年 After. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AftMedia.h"

NS_ASSUME_NONNULL_BEGIN

@interface AftMedia (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSString *coverUrl;
@property (nullable, nonatomic, retain) NSString *singer;
@property (nullable, nonatomic, retain) NSString *fileName;
@property (nullable, nonatomic, retain) NSString *album;
@property (nullable, nonatomic, retain) NSDate *publishDate;

@end

NS_ASSUME_NONNULL_END
