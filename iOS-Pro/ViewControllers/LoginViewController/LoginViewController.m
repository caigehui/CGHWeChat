//
//  LoginViewController.m
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
@interface LoginViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation LoginViewController
{
    
    UITextField *_passwordTextField;
    UIButton *_loginBtn;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    //绑定模型
    [self bindModel];
}

//绑定模型
- (void)bindModel
{
    
   
    self.loginViewModel.username = @"13202440650";
    RAC(self.loginViewModel, password) = _passwordTextField.rac_textSignal;
    
    __weak typeof(self) weakself = self;
    [[[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        
        //防止多次点击登录
        _loginBtn.enabled = NO;
    }] subscribeNext:^(id x) {
        
        [weakself.loginViewModel.loginCommand execute:nil];
    }];
}

#pragma mark - getters and setters 
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        scrollView.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        _scrollView = scrollView;
        
        UIImageView *headImageView = [[UIImageView alloc] init];
        [headImageView setImage:[UIImage imageNamed:@"headImage.JPG"]];
        headImageView.sd_cornerRadius = @(6.f*kAdaptPixeliPhone6);
        [scrollView addSubview:headImageView];
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.font = [UIFont boldSystemFontOfSize:16.0f*kAdaptPixeliPhone6];
        phoneLabel.textAlignment = NSTextAlignmentCenter;
        phoneLabel.text = @"+86  13202440650";
        [scrollView addSubview:phoneLabel];
        
        UILabel *pwdLabel = [[UILabel alloc] init];
        pwdLabel.font = [UIFont systemFontOfSize:15.0f*kAdaptPixeliPhone6];
        pwdLabel.text = @"密码";
        [scrollView addSubview:pwdLabel];
        
        UITextField *passwordTextField = [[UITextField alloc] init];
        passwordTextField.placeholder = @"请输入密码";
        passwordTextField.font = pwdLabel.font;
        passwordTextField.returnKeyType = UIReturnKeyGo;
        passwordTextField.secureTextEntry = YES;
        passwordTextField.tintColor = CustomColor(42, 179, 9, 1);
        passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [scrollView addSubview:passwordTextField];
        _passwordTextField = passwordTextField;
        
        UIView *sepLine = [[UIView alloc] init];
        sepLine.backgroundColor = SepColor;
        [scrollView addSubview:sepLine];
        
        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f*kAdaptPixeliPhone6];
        _loginBtn = loginBtn;
        loginBtn.sd_cornerRadius = @(5.f*kAdaptPixeliPhone6);
        [scrollView addSubview:loginBtn];
        
        
        //改变登录按钮的状态，无密码时无法点击
        [[[_passwordTextField.rac_textSignal map:^id(id value) {
            
            return @(_passwordTextField.text.length);
        }] map:^id(NSNumber *length) {
            
            [_loginBtn setTitleColor:[length integerValue] >= 8?[UIColor whiteColor]:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
            [_loginBtn setEnabled:[length integerValue] >= 8];
            return [length integerValue] > 8?CustomColor(42, 182, 8, 1):CustomColor(91, 211, 85, 1);
        }] subscribeNext:^(id x) {
            
            _loginBtn.backgroundColor = (UIColor*)x;
        }];
        
        
        UIButton *helpBtn = [[UIButton alloc] init];
        [helpBtn setTitleColor:CustomColor(143, 152, 180, 1) forState:UIControlStateNormal];
        [helpBtn setTitle:@"登录遇到问题?" forState:UIControlStateNormal];
        helpBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f*kAdaptPixeliPhone6];
        [scrollView addSubview:helpBtn];
        
        UIButton *moreBtn = [[UIButton alloc] init];
        [moreBtn setTitleColor:CustomColor(143, 152, 180, 1) forState:UIControlStateNormal];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f*kAdaptPixeliPhone6];
        [self.view addSubview:moreBtn];
        
        headImageView.sd_layout
        .yIs(80*kAdaptPixeliPhone6)
        .centerXIs(kScreen_Width/2)
        .widthIs(80*kAdaptPixeliPhone6)
        .heightIs(78*kAdaptPixeliPhone6);
        
        phoneLabel.sd_layout
        .topSpaceToView(headImageView, 10*kAdaptPixeliPhone6)
        .centerXEqualToView(headImageView)
        .heightIs(20*kAdaptPixeliPhone6)
        .widthIs(kScreen_Width);
        
        pwdLabel.sd_layout
        .topSpaceToView(phoneLabel, 30*kAdaptPixeliPhone6)
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6);
        [pwdLabel setSingleLineAutoResizeWithMaxWidth:50*kAdaptPixeliPhone6];
        
        passwordTextField.sd_layout
        .leftSpaceToView(pwdLabel, 40*kAdaptPixeliPhone6)
        .topEqualToView(pwdLabel)
        .rightSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6);
        
        sepLine.sd_layout
        .topSpaceToView(pwdLabel, 0*kAdaptPixeliPhone6)
        .widthIs(kScreen_Width)
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(0.75*kAdaptPixeliPhone6);
        
        loginBtn.sd_layout
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .topSpaceToView(sepLine, 20*kAdaptPixeliPhone6)
        .rightSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(40*kAdaptPixeliPhone6);
        
        helpBtn.sd_layout
        .topSpaceToView(loginBtn, 15*kAdaptPixeliPhone6)
        .widthIs(100*kAdaptPixeliPhone6)
        .centerXIs(kScreen_Width/2)
        .heightIs(15*kAdaptPixeliPhone6);
        
        moreBtn.sd_layout
        .heightIs(20*kAdaptPixeliPhone6)
        .bottomSpaceToView(self.view, 15*kAdaptPixeliPhone6)
        .widthIs(50*kAdaptPixeliPhone6)
        .centerXIs(kScreen_Width/2);
        
    }
    return _scrollView;
}

- (LoginViewModel *)loginViewModel
{
    if (!_loginViewModel) {
        @weakify(self);
        _loginViewModel = [[LoginViewModel alloc] initWithLoginSuccess:^{
            @strongify(self);
            //跳转
            _loginBtn.enabled = YES;
            NSLog(@"登录成功!");
        } failure:^(NSString *msg) {
            @strongify(self);
            //失败处理
            _loginBtn.enabled = YES;
            NSLog(@"登录失败!");
        }];
    }
    return _loginViewModel;
}

@end
