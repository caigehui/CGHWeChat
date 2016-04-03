//
//  LoginViewController.m
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "PQActionSheet.h"
#import "Config.h"
#import "UIView+SDAutoLayout.h"
@interface LoginViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *switchScrollView;

@property (nonatomic, strong) LoginViewModel *loginViewModel;

@property (nonatomic, strong) PQActionSheet *moreActionSheet;
@property (nonatomic, strong) PQActionSheet *helpActionSheet;
@end

@implementation LoginViewController
{
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    UIButton *_loginBtn;
    UIButton *_moreBtn;
    UIButton *_cancelBtn;
    LoginType _loginType;
}

#pragma mark - life cycle

- (instancetype)initWithType:(LoginType)loginType
{
    self = [super init];
    if (self) {
        _loginType = loginType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加控件
    [self.view addSubview:_loginType == LoginTypeDefault?self.scrollView:self.switchScrollView];
    [self.view bringSubviewToFront:_loginType == LoginTypeDefault?_moreBtn:_cancelBtn];
    
    //绑定模型
    [self bindModel];
    
    //绑定登录按钮的状态
    [self updateLoginBtnState];
}

//绑定模型
- (void)bindModel
{
    //绑定了用户名和密码
    if (_loginType == LoginTypeDefault) {
        self.loginViewModel.username = @"13202440650";
    }else {
        RAC(self.loginViewModel, username) = _usernameTextField.rac_textSignal;
    }
    RAC(self.loginViewModel, password) = _passwordTextField.rac_textSignal;
    
    __weak typeof(self) weakself = self;
    [[[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        
        [_usernameTextField resignFirstResponder];
        [_passwordTextField resignFirstResponder];
        //防止多次点击登录
        _loginBtn.enabled = NO;
        
    }] subscribeNext:^(id x) {
        
        [weakself.loginViewModel.loginCommand execute:nil];
        _loginBtn.enabled = YES;
    }];
    
    //订阅登录后
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *msg) {
        
        if ([msg isEqualToString:LoginSuccessMsg]) {
            
        }else {
            
        }
    }];
}

//绑定登录按钮的状态
- (void)updateLoginBtnState
{
    if (_loginType == LoginTypeDefault) {
        //当登录是默认用户时
        RAC(_loginBtn, backgroundColor) = [[_passwordTextField.rac_textSignal map:^id(NSString *text) {
            
            return @(text.length);
        }] map:^id(NSNumber *length) {
            
            [_loginBtn setTitleColor:[length integerValue] >= 8?[UIColor whiteColor]:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
            [_loginBtn setEnabled:[length integerValue] >= 8];
            return [length integerValue] > 8?CustomColor(42, 182, 8, 1):CustomColor(91, 211, 85, 1);
        }];
    }else if (_loginType == LoginTypeSwitchAccount) {
        //当切换用户时
        RAC(_loginBtn, backgroundColor) = [RACSignal combineLatest:@[[_usernameTextField.rac_textSignal
                                                                      map:^id(NSString *text) {
                                                                          return @(text.length);
                                                                      }],
                                                                     [_passwordTextField.rac_textSignal
                                                                      map:^id(NSString *text) {
                                                                          return @(text.length);
                                                                      }]]
                                                            reduce:^id(NSNumber *usernameTextLength, NSNumber *passwordTextLength){
                                                                
                                                                BOOL valid = [usernameTextLength integerValue] !=0 && [passwordTextLength integerValue] >= 8;
                                                                
                                                                [_loginBtn setTitleColor:valid?[UIColor whiteColor]:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
                                                                [_loginBtn setEnabled:valid];
                                                                
                                                                return valid?CustomColor(42, 182, 8, 1):CustomColor(91, 211, 85, 1);
                                                            }];
    }
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
        [loginBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
        loginBtn.backgroundColor = CustomColor(91, 211, 85, 1);
        [loginBtn setEnabled:NO];
        loginBtn.sd_cornerRadius = @(5.f*kAdaptPixeliPhone6);
        [scrollView addSubview:loginBtn];
        
        
        UIButton *helpBtn = [[UIButton alloc] init];
        [helpBtn setTitleColor:CustomColor(143, 152, 180, 1) forState:UIControlStateNormal];
        [helpBtn setTitle:@"登录遇到问题?" forState:UIControlStateNormal];
        helpBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f*kAdaptPixeliPhone6];
        [scrollView addSubview:helpBtn];
        @weakify(self)
        [[helpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self.helpActionSheet show];
        }];
        
        UIButton *moreBtn = [[UIButton alloc] init];
        [moreBtn setTitleColor:CustomColor(143, 152, 180, 1) forState:UIControlStateNormal];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f*kAdaptPixeliPhone6];
        [self.view addSubview:moreBtn];
        _moreBtn = moreBtn;
        [[moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            @strongify(self);
            [self.moreActionSheet show];
        }];
        
        
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
        .heightIs(30*kAdaptPixeliPhone6)
        .bottomSpaceToView(self.view, 10*kAdaptPixeliPhone6)
        .widthIs(50*kAdaptPixeliPhone6)
        .centerXIs(kScreen_Width/2);
        
    }
    return _scrollView;
}

- (UIScrollView *)switchScrollView
{
    if (!_switchScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        scrollView.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        _switchScrollView = scrollView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:20.f*kAdaptPixeliPhone6];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"使用账号和密码登录";
        [scrollView addSubview:titleLabel];
        
        UILabel *accountLabel = [[UILabel alloc] init];
        accountLabel.font = [UIFont systemFontOfSize:15.0f*kAdaptPixeliPhone6];
        accountLabel.text = @"账号";
        [scrollView addSubview:accountLabel];
        
        UITextField *usernameTextField = [[UITextField alloc] init];
        usernameTextField.placeholder = @"微信号/邮箱地址/QQ号";
        usernameTextField.font = accountLabel.font;
        usernameTextField.keyboardType = UIKeyboardTypeAlphabet;
        usernameTextField.returnKeyType = UIReturnKeyNext;
        usernameTextField.tintColor = CustomColor(42, 179, 9, 1);
        usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [scrollView addSubview:usernameTextField];
        _usernameTextField = usernameTextField;
        
        UIView *sepLine = [[UIView alloc] init];
        sepLine.backgroundColor = SepColor;
        [scrollView addSubview:sepLine];
        
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
        
        UIView *sepLine2 = [[UIView alloc] init];
        sepLine2.backgroundColor = SepColor;
        [scrollView addSubview:sepLine2];
        
        UIButton *loginBtn = [[UIButton alloc] init];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f*kAdaptPixeliPhone6];
        _loginBtn = loginBtn;
        [loginBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateNormal];
        loginBtn.backgroundColor = CustomColor(91, 211, 85, 1);
        [loginBtn setEnabled:NO];
        loginBtn.sd_cornerRadius = @(5.f*kAdaptPixeliPhone6);
        [scrollView addSubview:loginBtn];
        
        
        
        UIButton *helpBtn = [[UIButton alloc] init];
        [helpBtn setTitleColor:CustomColor(143, 152, 180, 1) forState:UIControlStateNormal];
        [helpBtn setTitle:@"登录遇到问题?" forState:UIControlStateNormal];
        helpBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f*kAdaptPixeliPhone6];
        [scrollView addSubview:helpBtn];
        @weakify(self)
        [[helpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self.helpActionSheet show];
        }];
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTitleColor:CustomColor(42, 182, 8, 1) forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.f*kAdaptPixeliPhone6];
        [self.view addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
        [[[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
            //防止多次点击
            cancelBtn.enabled = NO;
        }] subscribeNext:^(id x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        titleLabel.sd_layout
        .topSpaceToView(scrollView, 80*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6)
        .centerXIs(kScreen_Width/2)
        .widthIs(kScreen_Width);
        
        accountLabel.sd_layout
        .topSpaceToView(titleLabel, 50*kAdaptPixeliPhone6)
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6);
        [accountLabel setSingleLineAutoResizeWithMaxWidth:50*kAdaptPixeliPhone6];
        
        usernameTextField.sd_layout
        .leftSpaceToView(accountLabel, 40*kAdaptPixeliPhone6)
        .topEqualToView(accountLabel)
        .rightSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6);
        
        sepLine.sd_layout
        .topSpaceToView(accountLabel, 0)
        .widthIs(kScreen_Width)
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(0.75*kAdaptPixeliPhone6);
        
        pwdLabel.sd_layout
        .topSpaceToView(sepLine, 5*kAdaptPixeliPhone6)
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6);
        [pwdLabel setSingleLineAutoResizeWithMaxWidth:50*kAdaptPixeliPhone6];
        
        passwordTextField.sd_layout
        .leftSpaceToView(pwdLabel, 40*kAdaptPixeliPhone6)
        .topEqualToView(pwdLabel)
        .rightSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(30*kAdaptPixeliPhone6);
        
        sepLine2.sd_layout
        .topSpaceToView(pwdLabel, 0*kAdaptPixeliPhone6)
        .widthIs(kScreen_Width)
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(0.75*kAdaptPixeliPhone6);
        
        loginBtn.sd_layout
        .leftSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .topSpaceToView(sepLine2, 20*kAdaptPixeliPhone6)
        .rightSpaceToView(scrollView, 15*kAdaptPixeliPhone6)
        .heightIs(40*kAdaptPixeliPhone6);
        
        helpBtn.sd_layout
        .topSpaceToView(loginBtn, 15*kAdaptPixeliPhone6)
        .widthIs(100*kAdaptPixeliPhone6)
        .centerXIs(kScreen_Width/2)
        .heightIs(15*kAdaptPixeliPhone6);
        
        cancelBtn.sd_layout
        .heightIs(20*kAdaptPixeliPhone6)
        .topSpaceToView(self.view, 30*kAdaptPixeliPhone6)
        .widthIs(35*kAdaptPixeliPhone6)
        .leftSpaceToView(self.view, 12*kAdaptPixeliPhone6);
    }
    return _switchScrollView;
}

- (LoginViewModel *)loginViewModel
{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (PQActionSheet *)moreActionSheet
{
    if (!_moreActionSheet) {
        _moreActionSheet = [[PQActionSheet alloc] initWithTitle:@"更多选项" clickedAtIndex:^(NSInteger index) {
            
            switch (index) {
                case 0:
                    
                    [self presentViewController:[[LoginViewController alloc] initWithType:LoginTypeSwitchAccount] animated:YES completion:nil];
                    break;
                    
                default:
                    break;
            }
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"切换用户", nil];
    }
    return _moreActionSheet;
}

- (PQActionSheet *)helpActionSheet
{
    if (!_helpActionSheet) {
        _helpActionSheet = [[PQActionSheet alloc] initWithTitle:@"登录遇到问题?" clickedAtIndex:^(NSInteger index) {
            
        } cancelButtonTitle:@"取消" otherButtonTitles:@"找回密码", @"发送验证短信", nil];
    }
    return _helpActionSheet;
}

@end
