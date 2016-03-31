//
//  AccountManager.m
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager
SYNTHESIZE_SINGLETON_FOR_CLASS(AccountManager)

- (void)loginUsername:(NSString*)username
             password:(NSString*)password
              success:(void(^)(AccountModel *accountModel))success
              failure:(FailureBlock)failure
{
    
    
    [self sendRequestWithDictionary:@{
                                      @"tranCode":@"登录",
                                      @"username":username,
                                      @"password":password
                                      }
                            success:^(NSDictionary *dict) {
                                
                                NSError *error = nil;
                                AccountModel *accountModel = [MTLJSONAdapter modelOfClass:AccountModel.class fromJSONDictionary:dict error:&error];
                                success(accountModel);
                                }
                            failure:^(NSString *msg) {
                                
                                //假数据
                                NSError *error = nil;
                                AccountModel *accountModel = [MTLJSONAdapter modelOfClass:AccountModel.class fromJSONDictionary:@{@"userId":@(20132003019),@"name":@"caigehui",@"sex":@"1",@"telphone":@"13202440650"} error:&error];
                                success(accountModel);
                                
                                //failure(msg);
                                
                            }];
}

@end
