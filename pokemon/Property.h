//
//  Property.h
//  pokemon
//
//  Created by 王建平 on 13-7-6.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Property : NSObject {
    NSMutableArray *properyArray;
}

@property int id;
@property NSString *shape;
@property int type1;
@property int type2;

- (void)addProperty:(int)value;
- (NSMutableArray *)getPropertyArray;

@end
