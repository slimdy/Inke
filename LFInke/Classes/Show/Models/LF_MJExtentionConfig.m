//
//  LF_MJExtentionConfig.m
//  LFInke
//
//  Created by slimdy on 2017/5/9.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_MJExtentionConfig.h"
#import "LF_CreatorModel.h"
#import "LF_HotLiveModel.h"
@implementation LF_MJExtentionConfig
+(void)load{
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
    [LF_CreatorModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"desc" : @"description"
                 };
    }];
    
    //驼峰转下划线
    [LF_CreatorModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [LF_HotLiveModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
}
@end
