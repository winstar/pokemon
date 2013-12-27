//
//  Move.h
//  pokemon
//
//  Created by 王建平 on 13-7-22.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Move : NSObject

@property int ID;
@property NSString *name;
@property int property;
@property int category;
@property int power;
@property int hitRate;
@property int pp;

@end
