//
//  LoginViewModel.h
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#define LoginSuccessMsg @"登陆成功"

@interface LoginViewModel : NSObject
;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
