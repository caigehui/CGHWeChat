//
//  PQActionSheet.m
//  PQActionSheet
//
//  Created by Docee on 16/3/3.
//  Copyright © 2016年 temobi. All rights reserved.
//

#import "PQActionSheet.h"

//@brief 按钮的高度
#define ACTION_SHEET_BTN_HEIGHT 55.0f

@interface PQActionSheet () <UITableViewDelegate,UITableViewDataSource>

@property (copy,nonatomic) ClickedIndexBlock block;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *backgroundView;

@property (strong,nonatomic) NSMutableArray *otherButtons;

@property (assign,nonatomic) CGFloat tableViewHeight;
@property (assign,nonatomic) NSInteger buttonCount;

@end

@implementation PQActionSheet

#pragma mark - LifeCycle

/**
 *  @brief 初始化PQActionSheet
 *
 *  @param title                  ActionSheet标题
 *  @param delegate               委托
 *  @param cancelButtonTitle      取消按钮标题
 *  @param otherButtonTitles      其他按钮标题
 *
 *  @return PQActionSheet
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<PQActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        
        self.titleText = [title copy];
        self.cancelText = [cancelButtonTitle copy];
        self.delegate = delegate;
        
        self.otherButtons = [[NSMutableArray alloc]init];
        
        
        // 获取可变参数
        [_otherButtons addObject:otherButtonTitles];
        va_list list;
        NSString *curStr;
        va_start(list, otherButtonTitles);
        while ((curStr = va_arg(list, NSString *))) {
            
            [_otherButtons addObject:curStr];
            
        }

        //初始化子视图
        [self installSubViews];
        
        
    }
    return self;
}


/**
 *  @brief 初始化PQActionSheet(Block回调结果)
 *
 *  @param title             ActionSheet标题
 *  @param block             Block回调选中的Index
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitles 其他按钮标题
 *
 *  @return PQActionSheet
 */
- (instancetype)initWithTitle:(NSString *)title
               clickedAtIndex:(ClickedIndexBlock)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        
        
        //FIXME 宝宝还不知道如何传递可变参数，只能重复地再写一遍代码了
        
        self.titleText = [title copy];
        self.cancelText = [cancelButtonTitle copy];
        self.block = block;
        
        self.otherButtons = [[NSMutableArray alloc]init];
        
        
        // 获取可变参数
        [_otherButtons addObject:otherButtonTitles];
        va_list list;
        NSString *curStr;
        va_start(list, otherButtonTitles);
        while ((curStr = va_arg(list, NSString *))) {
            
            [_otherButtons addObject:curStr];
            
        }
        
        //初始化子视图
        [self installSubViews];
        
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Public Method

/**
 *  @brief 显示ActionSheet
 */
- (void)show
{
    
    __block typeof(self) weakSelf = self;
    
    if([_delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        
        [_delegate willPresentActionSheet:weakSelf];
        
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.hidden = NO;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.tableView.frame;
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height - self.tableViewHeight;
        
        weakSelf.tableView.frame = frame;
        
        weakSelf.tableView.hidden = NO;
        
    } completion:^(BOOL finished) {
        
        
        if([_delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
            
            [_delegate didPresentActionSheet:weakSelf];
            
        }
        
        
    }];
}

/**
 *  @brief 隐藏ActionSheet
 */
-(void)hide
{
    __block typeof(self) weakSelf = self;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = weakSelf.tableView.frame;
        CGSize screenSisze = [UIScreen mainScreen].bounds.size;
        frame.origin.y = screenSisze.height + self.tableViewHeight;
        
        weakSelf.tableView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        weakSelf.hidden = YES;
        weakSelf.tableView.hidden = YES;
        [weakSelf removeFromSuperview];
        
    }];
}

/**
 *  @brief 添加按钮
 *
 *  @param title 按钮标题
 *
 *  @return 按钮的Index
 */
- (NSInteger)addButtonWithTitle:(NSString *)title {
    
    [self.otherButtons addObject:[title copy]];
    
    return self.otherButtons.count - 1;
    
}

#pragma mark - Private

/**
 *  @brief 初始化子视图
 */
- (void)installSubViews {
    
    self.frame = [UIScreen mainScreen].bounds;
    
    // 初始化遮罩视图
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.142 alpha:1.000];
    self.backgroundView.alpha = 0.4f;
    [self addSubview:_backgroundView];
    
    
    // 初始化TableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,self.bounds.size.height, self.bounds.size.width, self.tableViewHeight)
                                                 style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:_tableView];
    
    // TableView加上高斯模糊效果
    if (NSClassFromString(@"UIVisualEffectView") && !UIAccessibilityIsReduceTransparencyEnabled()) {
        self.tableView.backgroundColor = [UIColor clearColor];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        [blurEffectView setFrame:self.tableView.frame];
        
        self.tableView.backgroundView = blurEffectView;
    }
    
    
    // 遮罩加上手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.backgroundView addGestureRecognizer:tap];
    
    self.hidden = YES;
    self.tableView.hidden = YES;
    
    
    //监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
}

#pragma mark - Util
/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
-(UIImage *)imageWithUIColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark - GET/SET

/**
 *  @brief TableView高度
 *
 *  @return TableView高度
 */
-(CGFloat)tableViewHeight {
    
    return self.buttonCount * ACTION_SHEET_BTN_HEIGHT;
    
}

/**
 *  @brief 按钮的总个数(包括Title和取消)
 *
 *  @return 按钮的总个数
 */
-(NSInteger)buttonCount {
    
    NSInteger count = 0;
    if(self.titleText && ![@"" isEqualToString:self.titleText]) {
        count+=1;
    }
    
    if(self.cancelText && ![@"" isEqualToString:self.cancelText]) {
        count+=1;
    }
    
    count+=self.otherButtons.count;

    
    return count;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return ACTION_SHEET_BTN_HEIGHT;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if(section == 0 && self.titleText) {
        
        return ACTION_SHEET_BTN_HEIGHT;
        
    }
    
    if(section == 1 && self.cancelText) {
        
        return 5.0f;
        
    }
    
    return 0.0f;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(section == 0 && self.titleText) {
        
        UILabel *label = [[UILabel alloc]init];
        [label setFont:[UIFont systemFontOfSize:15.0f]];
        [label setText:self.titleText];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        [label setAdjustsFontSizeToFitWidth:YES];
        UIImageView *sepLine = [[UIImageView alloc]initWithImage:[self imageWithUIColor:[UIColor grayColor]]];
        sepLine.frame = CGRectMake(0, ACTION_SHEET_BTN_HEIGHT - 0.3f, self.tableView.bounds.size.width, 0.3f);
        [label addSubview:sepLine];
        
        return label;
    }
    
    
    if(section == 1 && self.cancelText) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor grayColor];
        
        return view;
        
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = self.otherButtons.count;
    
    if(indexPath.section == 0) {
        index = indexPath.row;
    }
    
    
    // 委托方式返回结果
    if([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        
        [_delegate actionSheet:self clickedButtonAtIndex:index];
        
    }
    
    // Block方式返回结果
    if(self.block) {
        
        self.block(index);
        
    }
    
    [self hide];
    
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"actionsheetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identify];
        
        if (NSClassFromString(@"UIVisualEffectView") ) {
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.layer.masksToBounds = YES;
        
        // 加上分割线
        UIImageView *sepLine = [[UIImageView alloc]initWithImage:[self imageWithUIColor:[UIColor grayColor]]];
        sepLine.frame = CGRectMake(0, ACTION_SHEET_BTN_HEIGHT - 0.3f, [UIScreen mainScreen].bounds.size.width, 0.3f);
        [sepLine setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [cell addSubview:sepLine];
        
    }
    
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    if(indexPath.section == 0){
        
        [cell.textLabel setText:self.otherButtons[indexPath.row]];
        
    }
    
    if(indexPath.section == 1){
        
        [cell.textLabel setText:self.cancelText];
        
    }
    
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(self.cancelText) {
        
        return 2;
        
    }
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0) {
        
        return self.otherButtons.count;
        
    }
    
    if(section == 1 && self.cancelText) {
        
        return 1;
        
    }
    
    return 0;
    
}


#pragma mark - Observer

// 监听屏幕旋转方向
-(void)statusBarOrientationChange:(NSNotification *)notification {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    // iOS8以下宽高不会自动交换
    if(orientation != UIInterfaceOrientationPortrait) {
        
        if([UIDevice currentDevice].systemVersion.floatValue < 8.0f) {
            
            self.frame = CGRectMake(0, 0, screenSize.height, screenSize.width);
            
        }
    }
    
    self.backgroundView.frame = self.frame;
    
    CGRect tableViewRect = self.tableView.frame;
//    tableViewRect.size.width = self.frame.size.width;
//    tableViewRect.size.height = self.frame.size.height;
    
    if(orientation == UIInterfaceOrientationPortrait) {
        tableViewRect.origin.y+=fabs(screenSize.height-screenSize.width);
    }else {
        tableViewRect.origin.y = self.frame.size.height - self.tableViewHeight;
    }
    
    
    self.tableView.frame = tableViewRect;
    
    [self.tableView reloadData];
    
}

@end
