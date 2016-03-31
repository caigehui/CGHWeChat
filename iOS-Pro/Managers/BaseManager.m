//
//  BaseManager.m
//  BaoliProp
//
//  Created by caigehui on 16/3/11.
//  Copyright © 2016年 com.baoli. All rights reserved.
//

#import "BaseManager.h"
#import "SBJson.h"
#import <AFNetworking/AFNetworking.h>
@implementation BaseManager

- (void)sendRequestWithDictionary:(NSDictionary *)dict
                          success:(SuccessBlock)success
                          failure:(FailureBlock)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //转换成JSON字符串
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    NSString *reqStr = [jsonWriter stringWithObject:dict];
    
    [manager POST:PROTOCOL_URL
       parameters:@{@"reqStr":reqStr}
          success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //检验是否有result
        if ((result != nil) && [result isKindOfClass:[NSString class]] && [result length] > 0) {
            
            NSDictionary *dataDic = [result JSONValue];
            //msgCode为0时成功，为其他值时失败
            if (dataDic && [dataDic objectForKey:@"msgCode"] && [[dataDic objectForKey:@"msgCode"] integerValue] == 0) {
                
                success(dataDic);
                
            }else {
                
                failure([NSString stringWithFormat:@"%@", [dataDic objectForKey:@"msg"]]);
                
            }
            
        }else {
            
            failure(@"没有返回结果");
            
        }
        
    }
          failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(@"请求失败");
        
    }];
}



@end
