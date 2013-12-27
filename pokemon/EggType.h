//
//  EggType.h
//  pokemon
//
//  Created by 王建平 on 13-7-5.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EggType : NSObject {
    NSMutableDictionary *typeNameDic;
}

+ (EggType *)shareInstance;
- (NSString *)getTypeName:(int)index;

@end
