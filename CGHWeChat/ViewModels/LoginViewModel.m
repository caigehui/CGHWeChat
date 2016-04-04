//
//  LoginViewModel.m
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "LoginViewModel.h"
#import "SVProgressHUD.h"

@implementation LoginViewModel
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
            
            [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeBlack];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    [subscriber sendNext:LoginSuccessMsg];
                    [subscriber sendCompleted];
                });
                
                
            });
            
            
            return nil;
        }];
    }];
    
    
}

@end
