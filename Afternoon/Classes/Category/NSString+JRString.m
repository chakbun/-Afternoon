//
//  NSString+JRString.m
//  Afternoon
//
//  Created by Jaben on 16/3/31.
//  Copyright © 2016年 After. All rights reserved.
//

#import "NSString+JRString.h"
#import <UIKit/UIKit.h>

@implementation NSString (JRString)


- (BOOL)isContainsMsg:(NSString *)msg {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [self containsString:msg];
    }else {
        
        return [self rangeOfString:msg].length != 0;
    }
}

@end
