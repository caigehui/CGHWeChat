//
//  NSDictionaryUtil.h
//  EasyToo
//
//  Created by 郑 哲 on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionaryUtil : NSObject

#pragma get object from dictionary
//解析字符串
+ (NSString *)getDictionaryString:(NSDictionary *)dict forKey:(id)key defaultValue:(NSString*)fallback;
//解析int整数
+ (int)getDictionaryInt:(NSDictionary *)dict forKey:(id)key defaultValue:(int)fallback;
//解析long整数
+ (long)getDictionaryLong:(NSDictionary *)dict forKey:(id)key defaultValue:(long)fallback;
//解析bool变量
+ (bool)getDictionaryBool:(NSDictionary *)dict forKey:(id)key defaultValue:(bool)fallback;
//解析nsnumber
+ (NSNumber *)getDictionaryNumber:(NSDictionary *)dict forKey:(id)key defaultValue:(NSNumber*)fallback;
//解析nsdictionary
+ (NSDictionary *)getDictionaryDictionary:(NSDictionary *)dict forKey:(id)key defaultValue:(NSDictionary*)fallback;
//解析nsarray
+ (NSArray *)getDictionaryArray:(NSDictionary *)dict forKey:(id)key defaultValue:(NSArray*)fallback;

@end

@interface NSDictionary(EasyTooAddition)
//解析字符串
- (NSString *)objectStringForKey:(id)key;
- (NSString *)objectStringForKey:(id)key defaultValue:(NSString*)fallback;

//解析int整数
- (int)objectIntForKey:(id)key;
- (int)objectIntForKey:(id)key defaultValue:(int)fallback;

//解析long整数
- (long)objectLongForKey:(id)key;
- (long)objectLongForKey:(id)key defaultValue:(long)fallback;

//解析nsnumber
- (NSNumber *)objectNumberForKey:(id)key;
- (NSNumber *)objectNumberForKey:(id)key defaultValue:(NSNumber*)fallback;

//解析nsdictionary
- (NSDictionary *)objectDictionaryForKey:(id)key;
- (NSDictionary *)objectDictionaryForKey:(id)key defaultValue:(NSDictionary*)fallback;

//解析nsarray
- (NSArray*)objectArrayForKey:(id)key;
- (NSArray *)objectArrayForKey:(id)key defaultValue:(NSArray*)fallback;
@end
