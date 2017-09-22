//
//  LF_GetHotLiveTool.h
//  LFInke
//
//  Created by slimdy on 2017/5/9.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LF_GetHotLiveTool : NSObject
+(void)getHotLiveWithSuccess:(void(^)(id result))success failure:(void(^)(id error))failure;
+(void)getNearLiveWithSuccess:(void(^)(id result))success failure:(void(^)(id error))failure;
+(void)getAdvertisWithSuccess:(void(^)(id result))success failure:(void(^)(id error))failure;
@end
