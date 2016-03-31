//
//  LoginViewModel.m
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "LoginViewModel.h"
#import "AccountManager.h"
#import "SVProgressHUD.h"
#define LoginSuccessMsg @"登陆成功"

@interface LoginViewModel()

@property (nonatomic, copy) LoginSuccess success;
@property (nonatomic, copy) LoginFailure failure;

@end


@implementation LoginViewModel



- (instancetype)initWithLoginSuccess:(LoginSuccess)success
                             failure:(LoginFailure)failure
{
    self = [self init];
    if (self) {
        
        self.success = [success copy];
        self.failure = [failure copy];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialBind];
    }
    return self;
}

/**
 * 初始化绑定
 */
- (void)initialBind
{
    //登录逻辑
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //登录
            [[AccountManager sharedAccountManager] loginUsername:self.username password:self.password success:^(AccountModel *accountModel) {
                [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeBlack];
                //模拟网络延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
                    [subscriber sendNext:LoginSuccessMsg];
                    [subscriber sendCompleted];
                });
                
            } failure:^(NSString *msg) {
                [subscriber sendNext:msg];
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    
    //订阅登录
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *msg) {
        
        if ([msg isEqualToString:LoginSuccessMsg]) {
            self.success();
        }else {
            self.failure(msg);
        }
    }];
}

@end
