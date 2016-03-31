//
//  BaseManager.h
//  BaoliProp
//
//  Created by caigehui on 16/3/11.
//  Copyright © 2016年 com.baoli. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FailureBlock)(NSString *msg);
typedef void(^SuccessBlock)(NSDictionary *dict);

@interface BaseManager : NSObject
/**
 * 发送请求,成功时调用success,失败时调用failure(无图片)
 */
- (void)sendRequestWithDictionary:(NSDictionary *)dict
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure;

@end

