//
//  Evolution.h
//  pokemon
//
//  Created by 王建平 on 13-7-7.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evolution : NSObject

@property int fromId;
@property int toId;
@property NSString *method;
@property int level;
@property int iconId;

@end
