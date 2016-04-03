//
//  LoginViewController.h
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeDefault,
    LoginTypeSwitchAccount
};

@interface LoginViewController : UIViewController

- (instancetype)initWithType:(LoginType)loginType;

@end
