//
//  BaseNavigationController.m
//  CGHWeChat
//
//  Created by caigehui on 4/4/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ColorConfig.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:NAVBAR_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
