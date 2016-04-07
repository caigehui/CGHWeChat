//
//  SearchController.m
//  CGHWeChat
//
//  Created by caigehui on 4/5/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "SearchController.h"
#import "SearchViewController.h"
#import "ColorConfig.h"
@interface SearchController ()

@end

@implementation SearchController

#pragma mark - life cycle

- (instancetype)init
{
    return [super initWithSearchResultsController:[[SearchViewController alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
