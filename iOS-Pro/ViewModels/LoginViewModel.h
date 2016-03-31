//
//  LoginViewModel.h
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoginSuccess)(void);
typedef void(^LoginFailure)(NSString *msg);

@interface LoginViewModel : NSObject

- (instancetype)initWithLoginSuccess:(LoginSuccess)success
                             failure:(LoginFailure)failure;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
