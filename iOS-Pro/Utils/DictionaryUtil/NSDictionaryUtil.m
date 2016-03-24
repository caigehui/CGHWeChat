#import "NSDictionaryUtil.h"

@implementation NSDictionaryUtil

//解析字符串
+ (NSString *)getDictionaryString:(NSDictionary *)dict forKey:(id)key defaultValue:(NSString*)fallback
{
    return [NSDictionaryUtil getDictionaryObject:dict forKey:key defaultValue:fallback objectClass:[NSString class]];
}

//解析int整数
+ (int)getDictionaryInt:(NSDictionary *)dict forKey:(id)key defaultValue:(int)fallback
{
    NSNumber *result = [NSDictionaryUtil getDictionaryNumber:dict forKey:key defaultValue:[NSNumber numberWithInt:fallback]];
    return result.intValue;
}

//解析long整数
+ (long)getDictionaryLong:(NSDictionary *)dict forKey:(id)key defaultValue:(long)fallback
{
    NSNumber *result = [NSDictionaryUtil getDictionaryNumber:dict forKey:key defaultValue:[NSNumber numberWithLong:fallback]];
    return result.longValue;
}

//解析bool变量
+ (bool)getDictionaryBool:(NSDictionary *)dict forKey:(id)key defaultValue:(bool)fallback
{
    NSNumber *result = [NSDictionaryUtil getDictionaryNumber:dict forKey:key defaultValue:[NSNumber numberWithBool:fallback]];
    return result.boolValue;
}

//解析nsnumber
+ (NSNumber *)getDictionaryNumber:(NSDictionary *)dict forKey:(id)key defaultValue:(NSNumber*)fallback
{
    return [NSDictionaryUtil getDictionaryObject:dict forKey:key defaultValue:fallback objectClass:[NSNumber class]];
}

//解析nsdictionary
+ (NSDictionary *)getDictionaryDictionary:(NSDictionary *)dict forKey:(id)key defaultValue:(NSDictionary*)fallback
{
    return [NSDictionaryUtil getDictionaryObject:dict forKey:key
                                    defaultValue:fallback
                                     objectClass:[NSDictionary class]];
}

//解析nsarray
+ (NSArray *)getDictionaryArray:(NSDictionary *)dict forKey:(id)key defaultValue:(NSArray*)fallback
{
    return [NSDictionaryUtil getDictionaryObject:dict forKey:key
                                    defaultValue:fallback
                                     objectClass:[NSArray class]];
}

+ (id)getDictionaryObject:(NSDictionary *)dict forKey:(id)key defaultValue:(id)fallback objectClass:(Class)objectClass
{
    id result = [dict objectForKey:key];
    
    if (!result || ![result isKindOfClass:objectClass])
    {
        result = fallback;
    }
    return result;
}

@end

@implementation NSDictionary(EasyTooAddition)

//解析字符串
- (NSString *)objectStringForKey:(id)key
{
    return [self objectStringForKey:key defaultValue:nil];
}

- (NSString *)objectStringForKey:(id)key defaultValue:(NSString*)fallback
{
    return [self getDictionaryObjectForKey:key defaultValue:fallback objectClass:[NSString class]];
}

//解析int整数
- (int)objectIntForKey:(id)key
{
    return [self objectIntForKey:key defaultValue:0];
}

- (int)objectIntForKey:(id)key defaultValue:(int)fallback
{
    NSNumber *result = [self objectNumberForKey:key defaultValue:[NSNumber numberWithInt:fallback]];
    return result.intValue;
}

//解析long整数
- (long)objectLongForKey:(id)key
{
    return [self objectLongForKey:key defaultValue:0];
}

- (long)objectLongForKey:(id)key defaultValue:(long)fallback
{
    NSNumber *result = [self objectNumberForKey:key defaultValue:[NSNumber numberWithInteger:fallback]];
    return result.longValue;
}


//解析nsnumber
- (NSNumber *)objectNumberForKey:(id)key
{
    return [self objectNumberForKey:key defaultValue:[NSNumber numberWithInt:0]];
}

- (NSNumber *)objectNumberForKey:(id)key defaultValue:(NSNumber*)fallback
{
    return [self getDictionaryObjectForKey:key defaultValue:fallback objectClass:[NSNumber class]];
}

//解析nsdictionary
- (NSDictionary *)objectDictionaryForKey:(id)key
{
    return [self objectDictionaryForKey:key defaultValue:[NSMutableDictionary dictionaryWithCapacity:0]];
}
- (NSDictionary *)objectDictionaryForKey:(id)key defaultValue:(NSDictionary*)fallback
{
    return [self getDictionaryObjectForKey:key
                              defaultValue:fallback
                               objectClass:[NSDictionary class]];
}

//解析nsarray
- (NSArray*)objectArrayForKey:(id)key
{
    return [self objectArrayForKey:key defaultValue:[NSMutableArray arrayWithCapacity:0]];
}

- (NSArray *)objectArrayForKey:(id)key defaultValue:(NSArray*)fallback
{
    return [self getDictionaryObjectForKey:key
                              defaultValue:fallback
                               objectClass:[NSArray class]];
}

- (id)getDictionaryObjectForKey:(id)key defaultValue:(id)fallback objectClass:(Class)objectClass
{
    id result = [self objectForKey:key];
    
    if (!result || ![result isKindOfClass:objectClass])
    {
        result = fallback;
    }
    return result;
}


@end
