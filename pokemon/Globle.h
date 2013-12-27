//
//  Globle.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globle : NSObject {
    NSArray *nuliArray;
    NSArray *gexingArray;
    NSMutableArray *pokemons;
    NSDictionary *natureDic;
}

@property (nonatomic,assign) float globleWidth;
@property (nonatomic,assign) float globleHeight;
@property (nonatomic,assign) float viewHeight;

+ (Globle *)shareInstance;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
- (NSArray *)getNuLiArray;
- (NSArray *)getNatureArray;
- (NSString *)getNatureValue:(NSString *)key;
- (NSMutableArray *)getPokemons;

@end