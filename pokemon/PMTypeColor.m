//
//  PMTypeColor.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-24.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PMTypeColor.h"

static PMTypeColor *shareInstance = nil;

@implementation PMTypeColor {
    UIColor *category0;
    UIColor *category1;
    UIColor *category2;
}

+ (PMTypeColor *)shareInstance
{
    if (shareInstance == nil) {
        @synchronized(self)
        {
            if (shareInstance == nil) {
                shareInstance = [[PMTypeColor alloc] init];
            }
        }
    }
    return shareInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *plistURL = [bundle URLForResource:@"infoMap" withExtension:@"plist"];
        NSDictionary *typeDic = [NSDictionary dictionaryWithContentsOfURL:plistURL];
        typeNameDic = [NSMutableDictionary dictionaryWithCapacity:17];
        typeColorDic = [NSMutableDictionary dictionaryWithCapacity:17];
        for (int i = 1; i <= 18; i++) {
            NSString *index = [NSString stringWithFormat:@"%d", i];
            NSDictionary *typeItem = [typeDic objectForKey:index];
            NSString *name = [typeItem objectForKey:@"N"];
            int red = [[typeItem objectForKey:@"R"] intValue];
            int green = [[typeItem objectForKey:@"G"] intValue];
            int blue = [[typeItem objectForKey:@"B"] intValue];
            [typeNameDic setObject:name forKey:index];
            UIColor *color = [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1];
            [typeColorDic setObject:color forKey:index];
        }
        category0 = [UIColor colorWithRed:140/255.f green:136/255.f blue:140/255.f alpha:1];
        category1 = [UIColor colorWithRed:201/255.f green:33/255.f blue:18/255.f alpha:1];
        category2 = [UIColor colorWithRed:79/255.f green:88/255.f blue:112/255.f alpha:1];
    }
    return self;
}

+ (UIColor *)linkColor
{
    return [UIColor colorWithRed:0.1 green:0.5 blue:0.95 alpha:0.9];
}

+ (UIColor *)linkColor2
{
    return [UIColor colorWithRed:0.1 green:0.5 blue:0.95 alpha:0.4];
}

- (NSString *)getTypeName:(int)index
{
    if (index == 0) {
        return @"";
    } else {
        return [typeNameDic objectForKey:[NSString stringWithFormat:@"%d", index]];
    }
}

- (UIColor *)getTypeColor:(int)index
{
    if (index == 0) {
        return [UIColor clearColor];
    } else {
        return [typeColorDic objectForKey:[NSString stringWithFormat:@"%d", index]];
    }
}

- (NSString *)getCategoryName:(int)index
{
    if (index == 1) {
        return @"物理";
    } else if (index == 2) {
        return @"特殊";
    } else {
        return @"变化";
    }
}

- (UIColor *)getCategoryColor:(int)index
{
    if (index == 1) {
        return category1;
    } else if (index == 2) {
        return category2;
    } else {
        return category0;
    }
}

@end
