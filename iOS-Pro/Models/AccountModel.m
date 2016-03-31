//
//  AccountModel.m
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId":@"userId",
             @"name":@"name",
             @"sex":@"sex",
             @"telphone":@"telphone"
             };
}

+ (NSValueTransformer *)sexJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"0":@(Female),@"1":@(Male)}];
}

@end
