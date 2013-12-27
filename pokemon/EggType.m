//
//  EggType.m
//  pokemon
//
//  Created by 王建平 on 13-7-5.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "EggType.h"

static EggType *eggInstance = nil;

@implementation EggType

+ (EggType *)shareInstance
{
    if (eggInstance == nil) {
        @synchronized(self)
        {
            if (eggInstance == nil) {
                eggInstance = [[EggType alloc] init];
            }
        }
    }
    return eggInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *plistURL = [bundle URLForResource:@"egg" withExtension:@"plist"];
        NSDictionary *typeDic = [NSDictionary dictionaryWithContentsOfURL:plistURL];
        typeNameDic = [NSMutableDictionary dictionaryWithCapacity:17];
        for (int i = 1; i <= 16; i++) {
            NSString *index = [NSString stringWithFormat:@"%d", i];
            NSString *typeName = [typeDic objectForKey:index];
            [typeNameDic setObject:typeName forKey:index];
        }
    }
    return self;
}

- (NSString *)getTypeName:(int)index
{
    if (index == 0) {
        return @"";
    } else {
        return [typeNameDic objectForKey:[NSString stringWithFormat:@"%d", index]];
    }
}

@end
