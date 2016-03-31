//
//  AccountManager.h
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "BaseManager.h"
#import "SingletonTemplate.h"
#import "AccountModel.h"
@interface AccountManager : BaseManager
SYNTHESIZE_SINGLETON_FOR_HEADER(AccountManager)
/**
 * 登录
 */
- (void)loginUsername:(NSString*)username
             password:(NSString*)password
              success:(void(^)(AccountModel *accountModel))success
              failure:(FailureBlock)failure;

@end
