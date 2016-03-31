//
//  PQActionSheet.h
//  PQActionSheet
//
//  Created by Docee on 16/3/3.
//  Copyright © 2016年 temobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PQActionSheetDelegate;

typedef void(^ClickedIndexBlock)(NSInteger index);

@interface PQActionSheet : UIView


@property (weak,nonatomic) id<PQActionSheetDelegate> delegate;
@property (strong,nonatomic) NSString *titleText;
@property (strong,nonatomic) NSString *cancelText;


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
            otherButtonTitles:(NSString *)otherButtonTitles, ...;



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
            otherButtonTitles:(NSString *)otherButtonTitles, ...;



/**
 *  @brief 显示ActionSheet
 */
- (void)show;

/**
 *  @brief 添加按钮
 *
 *  @param title 按钮标题
 *
 *  @return 按钮的Index
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;


@end





@protocol PQActionSheetDelegate <NSObject>

@optional

/**
 *  @brief 被选中的按钮
 *
 *  @param actionSheet PQActionSheet
 *  @param buttonIndex 选中按钮的Index(取消按钮默认为最后一个按钮)
 */
- (void)actionSheet:(PQActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex;


/**
 *  @brief PQActionSheet将要显示
 *
 *  @param actionSheet PQActionSheet
 */
- (void)willPresentActionSheet:(PQActionSheet *)actionSheet;

/**
 *  @brief PQActionSheet已经显示
 *
 *  @param actionSheet PQActionSheet
 */
- (void)didPresentActionSheet:(PQActionSheet *)actionSheet;


@end
