//
//  Property.m
//  pokemon
//
//  Created by 王建平 on 13-7-6.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "Property.h"

@implementation Property

- (id)init
{
    self = [super init];
    if (self) {
        properyArray = [NSMutableArray arrayWithCapacity:18];
    }
    return self;
}

- (void)addProperty:(int)value
{
    if (value == 1) {
        [properyArray addObject:@"¼"];
    } else if (value == 2) {
        [properyArray addObject:@"½"];
    } else {
        [properyArray addObject:[NSString stringWithFormat:@"%d", value / 4]];
    }
}

- (NSMutableArray *)getPropertyArray
{
    return properyArray;
}

@end
