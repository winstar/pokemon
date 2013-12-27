//
//  Pokemon.h
//  pokemon
//
//  Created by 王建平 on 13-7-1.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EggType.h"

@interface Pokemon : NSObject

@property int id;
@property int natural;
@property int shapeID;
@property int kanto;
@property int johto;
@property int hoenn;
@property int sinnoh;
@property int unova;
@property  NSString *name;
@property NSString *shape;
@property int type1;
@property int type2;
@property int ability1ID;
@property NSString *ability1Name;
@property int ability2ID;
@property NSString *ability2Name;
@property int abilityHID;
@property NSString *abilityHName;
@property int egg1ID;
@property int egg2ID;

@property int catchRate;
@property int hatchStep;
@property int bodyStyle;
@property NSString *gender;
@property int color;
@property NSString *height;
@property NSString *weight;
@property int exp;

@property int baseHP;
@property int baseAttack;
@property int baseDefense;
@property int baseSpAttack;
@property int baseSpDefense;
@property int baseSpeed;

@property int evHP;
@property int evAttack;
@property int evDefense;
@property int evSpAttack;
@property int evSpDefense;
@property int evSpeed;

- (NSString *)getEggType;
- (NSString *)getEvStr;
- (NSString *)getGenderStr;

@end
