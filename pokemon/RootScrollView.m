//
//  RootScrollView.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "RootScrollView.h"
#import "Globle.h"
#import "TopScrollView.h"
#import "BasicInfoView.h"
#import "PropertyView.h"
#import "EvolutionView.h"
#import "LvMoveView.h"
#import "PokemonInfoViewController.h"
#import "xkViewController.h"
#import "UIImageView+LBBlurredImage.h"

#define POSITIONID (int)scrollView.contentOffset.x/320
#define TABCOUNT 4

@implementation RootScrollView {
    BasicInfoView *basicInfoView;
    PropertyView *propertyView;
    EvolutionView *evolutionView;
    LvMoveView *lvMoveView;
    UIImageView *bgImageView;
}

+ (RootScrollView *)shareInstance {
    static RootScrollView *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        float height = [[Globle shareInstance] viewHeight];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            __singletion=[[self alloc] initWithFrame:CGRectMake(0, 96, 320, height)];
        } else {
            __singletion=[[self alloc] initWithFrame:CGRectMake(0, 32, 320, height)];
        }
    });
    return __singletion;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        float height = [[Globle shareInstance] viewHeight];
        self.contentSize = CGSizeMake(320 * TABCOUNT, height);
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        
        //self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        userContentOffsetX = 0;
        
        [self initWithViews];
    }
    return self;
}

- (void)initWithViews
{
    float height = [[Globle shareInstance] viewHeight];
    for (int i = 0; i < TABCOUNT; i++) {
        if (i == 0) {
            basicInfoView = [[BasicInfoView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
            [self addSubview:basicInfoView];
        } else if (i == 1) {
            propertyView = [[PropertyView alloc] initWithFrame:CGRectMake(320, 0, 320, height)];
            [self addSubview:propertyView];
        } else if (i == 2) {
            evolutionView = [[EvolutionView alloc] initWithFrame:CGRectMake(640, 0, 320, height)];
            [self addSubview:evolutionView];
        } else {
            lvMoveView = [[LvMoveView alloc] initWithFrame:CGRectMake(960, 0, 320, height)];
            [self addSubview:lvMoveView];
        }
    }
}

- (void)setController:(UIViewController *)controller
{
    [evolutionView  setController:controller];
}

- (void) loadPMInfoById:(int)pmId Type:(int)type1
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
//    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    [basicInfoView loadData:pmId];
//    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    [propertyView loadData:pmId];
//    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    [evolutionView loadUI:pmId];
//    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    [lvMoveView loadData:pmId Type:type1];
//    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    userContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //调整顶部滑条按钮状态
    [self adjustTopScrollViewButton:scrollView];
}

- (void)adjustTopScrollViewButton:(UIScrollView *)scrollView
{
    [[TopScrollView shareInstance] setButtonUnSelect];
    [TopScrollView shareInstance].scrollViewSelectedChannelID = POSITIONID+100;
    [[TopScrollView shareInstance] setButtonSelect];
}

- (void)resetView
{
    userContentOffsetX = 0;
    [self setContentOffset:CGPointMake(0, 0) animated:NO];
    [[TopScrollView shareInstance] setButtonUnSelect];
    [TopScrollView shareInstance].scrollViewSelectedChannelID = 100;
    [[TopScrollView shareInstance] setButtonSelect];
}

@end
