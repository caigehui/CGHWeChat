//
//  Config.h
//  CGHWeChat
//
//  Created by caigehui on 4/2/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#ifndef Config_h
#define Config_h
#import "NSDictionaryUtil.h"
//屏幕适配
#define kAdaptPixeliPhone6 (kScreen_Width / 375.0f)

//自定义颜色
#define CustomColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SepColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

//获得iOS版本
#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue]

#define FirstWinow [[UIApplication sharedApplication].windows firstObject]

// 屏幕的宽、高
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kNavigationBar_Height 64


//调试模式下输入DLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif

/*========================================常用宏============================================*/
#define selfClassName() [NSString stringWithUTF8String:object_getClassName(self)]

#define GetStringDefaultEmpty(string) (string && [string isKindOfClass:[NSString class]] && [string length] > 0 ? string : @"")
#define IsStringNilOrEmpty(string)   ((string == nil) || ([string isKindOfClass:[NSString class]] && [string length] == 0))
#define IsStringNotNil(string) ((string != nil) && [string isKindOfClass:[NSString class]] && [string length] > 0)
/**
 *  比较字符串是否相等（忽略大小写），相等的话返回YES，否则返回NO
 */
#define AnydoorCompareString(thing1, thing2) (thing1 && [thing1 isKindOfClass:[NSString class]] && thing2 && [thing2 isKindOfClass:[NSString class]] && [thing1 compare:thing2 options:NSCaseInsensitiveSearch] == NSOrderedSame)

/*=========================================================================================*/
#define GetDictionaryStringDefaultNil(dict,key) [NSDictionaryUtil getDictionaryString:dict forKey:key defaultValue:nil]
#define GetDictionaryString(dict,key,default) [NSDictionaryUtil getDictionaryString:dict forKey:key defaultValue:default]
#define GetDictionaryNumberDefaultNil(dict,key) [NSDictionaryUtil getDictionaryNumber:dict forKey:key defaultValue:nil]
#define GetDictionaryNumber(dict,key,default) [NSDictionaryUtil getDictionaryNumber:dict forKey:key defaultValue:default]
#define GetDictionaryIntDefaultZero(dict,key) [NSDictionaryUtil getDictionaryInt:dict forKey:key defaultValue:0]
#define GetDictionaryInt(dict,key,default) [NSDictionaryUtil getDictionaryInt:dict forKey:key defaultValue:default]
#define GetDictionaryLongDefaultZero(dict,key) [NSDictionaryUtil getDictionaryLong:dict forKey:key defaultValue:0]
#define GetDictionaryLong(dict,key,default) [NSDictionaryUtil getDictionaryLong:dict forKey:key defaultValue:default]
#define GetDictionaryBoolDefaultFalse(dict,key) [NSDictionaryUtil getDictionaryLong:dict forKey:key defaultValue:false]
#define GetDictionaryBool(dict,key,default) [NSDictionaryUtil getDictionaryLong:dict forKey:key defaultValue:default]
#define GetDictionaryArrayDefaultNil(dict,key) [NSDictionaryUtil getDictionaryArray:dict forKey:key defaultValue:nil]
#define GetDictionaryArray(dict,key) [NSDictionaryUtil getDictionaryArray:dict forKey:key defaultValue:[NSMutableArray arrayWithCapacity:0]]
#define GetDictionaryDictionaryDefaultNil(dict,key) [NSDictionaryUtil getDictionaryDictionary:dict forKey:key defaultValue:nil]
#define GetDictionaryDictionary(dict,key) [NSDictionaryUtil getDictionaryDictionary:dict forKey:key defaultValue:[NSMutableDictionary dictionaryWithCapacity:0]]



#endif /* Config_h */
