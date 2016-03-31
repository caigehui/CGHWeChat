//
//  AccountModel.h
//  iOS-Pro
//
//  Created by caigehui on 3/31/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import <Mantle/Mantle.h>
//性别
typedef NS_ENUM(NSUInteger, Sex) {
    Male = 1,
    Female = 0
};
@interface AccountModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign, readonly) NSInteger userId;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) Sex sex;
@property (nonatomic, copy, readonly) NSString *telphone;


@end
