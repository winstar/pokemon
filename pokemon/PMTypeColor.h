//
//  PMTypeColor.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-24.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMTypeColor : NSObject {
    NSMutableDictionary *typeNameDic;
    NSMutableDictionary *typeColorDic;
}

+ (PMTypeColor *)shareInstance;
+ (UIColor *)linkColor;
+ (UIColor *)linkColor2;
- (NSString *)getTypeName:(int)index;
- (UIColor *)getTypeColor:(int)index;
- (NSString *)getCategoryName:(int)index;
- (UIColor *)getCategoryColor:(int)index;

@end
