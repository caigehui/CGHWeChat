

#import <Foundation/Foundation.h>


@interface NSMutableDictionary(TCAddition)

//设置非空的值
- (void)setNonEmptyObject:(id)object forKey:(id)key;

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

//设置int(自动转nsnumber)
- (void)setObjectInt:(int)intValue forKey:(id)key;

//设置bool(自动转nsnumber)
- (void)setObjectBool:(BOOL)boolValue forKey:(id)key;
@end