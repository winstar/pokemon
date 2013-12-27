//
//  TopScrollView.m
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import "TopScrollView.h"
#import "Globle.h"
#import "RootScrollView.h"

//按钮空隙
#define BUTTONGAP 5
//按钮长度
#define BUTTONWIDTH 74
//按钮宽度
#define BUTTONHEIGHT 30
//滑条CONTENTSIZEX
#define CONTENTSIZEX 280

#define BUTTONID (sender.tag-100)

@implementation TopScrollView

@synthesize nameArray;
@synthesize scrollViewSelectedChannelID;
@synthesize currPokemon;

+ (TopScrollView *)shareInstance {
    static TopScrollView *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            __singletion=[[self alloc] initWithFrame:CGRectMake(0, 64, 320, 32)];
        } else {
            __singletion=[[self alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
        }
    });
    return __singletion;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        //self.backgroundColor = [UIColor colorWithRed:238 green:232 blue:171 alpha:1];
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.nameArray = [NSArray arrayWithObjects:@"基本信息", @"属性相克", @"进化方式", @"招式技能", nil];
        self.contentSize = CGSizeMake((BUTTONWIDTH+BUTTONGAP)*[self.nameArray count]+BUTTONGAP, 44);
        
        userSelectedChannelID = 100;
        scrollViewSelectedChannelID = 100;
        
        [self initWithNameButtons];
    }
    return self;
}

- (void)initWithNameButtons
{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    [bgImageView setImage:[UIImage imageNamed:@"areabg.png"]];
    [bgImageView setAlpha:0.95];
    [self addSubview:bgImageView];
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 2, 74, 27)];
    [shadowImageView setImage:[UIImage imageNamed:@"areaSelect.png"]];
    [self addSubview:shadowImageView];
 
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(BUTTONGAP+(BUTTONGAP+BUTTONWIDTH)*i, 1, BUTTONWIDTH, 30)];
        [button setTag:i+100];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:[NSString stringWithFormat:@"%@",[self.nameArray objectAtIndex:i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)selectNameButton:(UIButton *)sender
{
    //如果更换按钮
    if (sender.tag != userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        [UIView animateWithDuration:0.25 animations:^{
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 2, 74, 27)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新闻页出现
                [[RootScrollView shareInstance] setContentOffset:CGPointMake(BUTTONID*320, 0) animated:NO];
                //赋值滑动列表选择频道ID
                scrollViewSelectedChannelID = sender.tag;
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIButton *button = (UIButton *)[self viewWithTag:scrollViewSelectedChannelID];
    
    [UIView animateWithDuration:0.15 animations:^{
        
        [shadowImageView setFrame:CGRectMake(button.frame.origin.x, 2, 74, 27)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!button.selected) {
                button.selected = YES;
                userSelectedChannelID = button.tag;
            }
        }
    }];
    
}

@end
