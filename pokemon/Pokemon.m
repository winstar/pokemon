//
//  Pokemon.m
//  pokemon
//
//  Created by 王建平 on 13-7-1.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (NSString *)getEggType
{
    EggType *eggType = [EggType shareInstance];
    NSString *egg1Name = [eggType getTypeName:self.egg1ID];
    if (self.egg2ID == 0) {
        return egg1Name;
    } else {
        NSString *egg2Name = [eggType getTypeName:self.egg2ID];
        return [NSString stringWithFormat:@"%@ %@", egg1Name, egg2Name];
    }
}

- (NSString *)getEvStr
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    if (self.evHP != 0) {
        [array addObject:[NSString stringWithFormat:@"HP+%d", self.evHP]];
    }
    if (self.evAttack != 0) {
        [array addObject:[NSString stringWithFormat:@"攻击+%d", self.evAttack]];
    }
    if (self.evDefense != 0) {
        [array addObject:[NSString stringWithFormat:@"防御+%d", self.evDefense]];
    }
    if (self.evSpAttack != 0) {
        [array addObject:[NSString stringWithFormat:@"特攻+%d", self.evSpAttack]];
    }
    if (self.evSpDefense != 0) {
        [array addObject:[NSString stringWithFormat:@"特防+%d", self.evSpDefense]];
    }
    if (self.evSpeed != 0) {
        [array addObject:[NSString stringWithFormat:@"速度+%d", self.evSpeed]];
    }
    return [array componentsJoinedByString:@" "];
}

- (NSString *)getGenderStr
{
    int male = 0, female = 0;
    if ([self.gender isEqualToString:@"0.875"]) {
        male = 7;
        female = 1;
    } else if ([self.gender isEqualToString:@"0.5"]) {
        male = 1;
        female = 1;
    } else if ([self.gender isEqualToString:@"0"]) {
        male = 0;
        female = 1;
    } else if ([self.gender isEqualToString:@"1"]) {
        male = 1;
        female = 0;
    } else if ([self.gender isEqualToString:@"0.25"]) {
        male = 1;
        female = 3;
    } else if ([self.gender isEqualToString:@"0.75"]) {
        male = 3;
        female = 1;
    } else if ([self.gender isEqualToString:@"-1"]) {
        male = 0;
        female = 0;
    }
    return [NSString stringWithFormat:@"♂%d ♀%d", male, female];
}

@end
