//
//  LF_ArchiveTool.h
//  LFInke
//
//  Created by slimdy on 2017/5/16.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LF_AccountModel;
@interface LF_ArchiveTool : NSObject
+(void)saveAccountModel:(LF_AccountModel *)account;
+(LF_AccountModel *)getAccount;
@end
