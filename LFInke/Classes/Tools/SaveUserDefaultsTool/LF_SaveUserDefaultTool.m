//
//  LF_SaveUserDefaultTool.m
//  LFInke
//
//  Created by slimdy on 2017/5/14.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_SaveUserDefaultTool.h"
#define ADIMAGEKEY @"adImage"
@implementation LF_SaveUserDefaultTool
+(void)setAdvImageName:(NSString*)imageName{
    [[NSUserDefaults standardUserDefaults] setObject:imageName forKey:ADIMAGEKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getAdvImageName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:ADIMAGEKEY];
}
@end
