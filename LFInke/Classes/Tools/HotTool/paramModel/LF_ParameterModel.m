//
//  LF_ParameterModel.m
//  LFInke
//
//  Created by slimdy on 2017/5/9.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ParameterModel.h"

@implementation LF_ParameterModel
-(NSString *)logid{
    if (!_logid) {
        _logid = @"185,165,205,208";
    }
    return _logid;
}

@end
