//
//  LF_HttpTool.m
//  LFInke
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_HttpTool.h"
static AFHTTPSessionManager *AFHttpClient =nil;
@implementation LF_HttpTool
+ (void)initialize
{
    
    if (self == [self class]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFHttpClient = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:SEVERHOST] sessionConfiguration:config];
        AFHttpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        AFHttpClient .requestSerializer.timeoutInterval = 15;
        AFHttpClient.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
    }
}
+(void)Get:(NSString *)url parameters:(id)param success:(void(^)(id responseOject))success failure:(void(^)(NSError *error))failure{
    [AFHttpClient GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)Post:(NSString *)url parameters:(id)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    [AFHttpClient POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
