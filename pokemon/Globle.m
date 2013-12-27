//
//  Globle.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "Globle.h"

@implementation Globle

@synthesize globleWidth, globleHeight, viewHeight;

+ (Globle *)shareInstance {
    static Globle *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion=[[self alloc] init];
    });
    return __singletion;
}

- (id) init
{
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *plistURL = [bundle URLForResource:@"nature" withExtension:@"plist"];
        natureDic = [NSDictionary dictionaryWithContentsOfURL:plistURL];
        CGRect rect = [[UIScreen mainScreen] bounds];
        CGSize size = rect.size;
        globleWidth = size.width;
        globleHeight = size.height;
        viewHeight = globleHeight - 96.f;
    }
    return self;
}

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

- (NSArray *)getNuLiArray
{
    if (nuliArray == nil) {
        nuliArray = [NSArray arrayWithObjects:@"全部为0", @"攻击 + 速度", @"特攻 + 速度", @"攻击 + 防御", @"攻击 + 特攻", @"特攻 + 特防",@"HP + 攻击", @"HP + 特攻",  @"HP + 速度", @"全满", nil];
    }
    return nuliArray;
}

- (NSArray *)getNatureArray
{
    return natureDic.allKeys;
}

- (NSString *)getNatureValue:(NSString *)key
{
    return [natureDic objectForKey:key];
}

- (NSMutableArray *)getPokemons
{
    return pokemons;
}
@end
