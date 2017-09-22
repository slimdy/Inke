//
//  LF_GetHotLiveTool.m
//  LFInke
//
//  Created by slimdy on 2017/5/9.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_GetHotLiveTool.h"
#import "LF_HttpTool.h"
#import "LF_ParameterModel.h"
#import "LF_HotLiveModel.h"
#import "LF_LocationTool.h"
#import "LF_NearParamModel.h"
#import "LF_AdvModel.h"
@implementation LF_GetHotLiveTool
+(void)getHotLiveWithSuccess:(void(^)(id result))success failure:(void(^)(id error))failure{
    LF_ParameterModel *parma = [[LF_ParameterModel alloc]init];
    if (!parma.logid) {
        if (failure) {
            failure(@"没有 logid");
        }
        return;
    }else{
        [LF_HttpTool Get:LIVEURL parameters:parma.mj_keyValues success:^(id responseOject) {
            if (success) {
                if ([responseOject[@"dm_error"] integerValue]) {
                    failure(responseOject[@"error_msg"]);
                }else{
                   NSArray *hotlives =  [LF_HotLiveModel mj_objectArrayWithKeyValuesArray:responseOject[@"lives"]];
                    success(hotlives);
                }
               
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    
}
+(void)getNearLiveWithSuccess:(void(^)(id result))success failure:(void(^)(id error))failure{
    LF_NearParamModel *parma = [[LF_NearParamModel alloc]init];
    if (!parma.uid) {
        if (failure) {
            failure(@"没有uid");
        }
        return;
    }else{
        [[LF_LocationTool shareLocationTool] getGps:^(NSString *lat, NSString *lon) {
            parma.latitude = lat;
            parma.longitude = lon;
           [LF_HttpTool Get:API_NearLive parameters:parma.mj_keyValues success:^(id responseOject) {
               if (success) {
                   if ([responseOject[@"dm_error"] integerValue]) {
                       failure(responseOject[@"error_msg"]);
                   }else{
                       NSArray *nearLives = [LF_HotLiveModel mj_objectArrayWithKeyValuesArray:responseOject[@"lives"]];
                       success(nearLives);
                   }
               }
           } failure:^(NSError *error) {
               if (failure) {
                   failure(error);
               }
           }];
        }];

     
    }
}

+(void)getAdvertisWithSuccess:(void(^)(id result))success failure:(void(^)(id error))failure{
    [LF_HttpTool Get:API_Advertise parameters:nil success:^(id responseOject) {
        if (success) {
            if ([responseOject[@"dm_error"] integerValue]) {
                failure(responseOject[@"error_msg"]);
            }else{
                LF_AdvModel *adv = [LF_AdvModel mj_objectWithKeyValues:responseOject[@"resources"][0]];
                NSLog(@"adv == %d",adv.position);
                success(adv);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
