
#import "NSMutableDictionary+Addition.h"

@implementation NSMutableDictionary(TCAddition)

- (void)setNonEmptyObject:(id)object forKey:(id)key
{
    if (object && key && ![object isEqual:[NSNull null]]) 
    {
        [self setObject:object forKey:key];
    }
}

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

//设置int(自动转nsnumber)
- (void)setObjectInt:(int)intValue forKey:(id)key
{
    [self setObject:[NSNumber numberWithInt:intValue] forKey:key];
}

//设置bool(自动转nsnumber)
- (void)setObjectBool:(BOOL)boolValue forKey:(id)key
{
    [self setObject:[NSNumber numberWithInt:boolValue?1:0] forKey:key];
}

@end
