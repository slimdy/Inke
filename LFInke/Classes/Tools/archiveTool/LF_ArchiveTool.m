//
//  LF_ArchiveTool.m
//  LFInke
//
//  Created by slimdy on 2017/5/16.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ArchiveTool.h"
#import "LF_AccountModel.h"
#define LFArchivePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@implementation LF_ArchiveTool
static LF_AccountModel *account = nil;
+(void)saveAccountModel:(LF_AccountModel *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:LFArchivePath];
}
+(LF_AccountModel *)getAccount{
    if (account == nil) {
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:LFArchivePath];
    }
    return account;
}
@end
