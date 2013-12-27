//
//  PMListTopScrollView.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-23.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "PMListTopScrollView.h"
#import "Globle.h"

//按钮空隙
#define BUTTONGAP 5
//按钮长度
#define BUTTONWIDTH 45
//按钮宽度
#define BUTTONHEIGHT 30
//滑条CONTENTSIZEX
#define CONTENTSIZEX 280

#define BUTTONID (sender.tag-100)

@implementation PMListTopScrollView

@synthesize nameArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.nameArray = [NSArray arrayWithObjects:@"全国", @"关东", @"城都", @"丰缘", @"神奥", @"合众", nil];
        self.contentSize = CGSizeMake((BUTTONWIDTH+BUTTONGAP)*[self.nameArray count]+BUTTONGAP, 44);
        
        userSelectedChannelID = 100;
        
        [self initWithNameButtons];
    }
    return self;
}

- (void)initWithNameButtons
{
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    [bgImageView setImage:[UIImage imageNamed:@"areabg.png"]];
    bgImageView.alpha = 0.95;
    [self addSubview:bgImageView];
    shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 42, 27)];
    [shadowImageView setImage:[UIImage imageNamed:@"areaSelect.png"]];
    [self addSubview:shadowImageView];
    
    for (int i = 0; i < [self.nameArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(10+(BUTTONGAP+BUTTONWIDTH)*i, 1, BUTTONWIDTH, 30)];
        [button setTag:i+100];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:[NSString stringWithFormat:@"%@",[self.nameArray objectAtIndex:i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
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
            
            [shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 2, 42, 27)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                NSString *area = [NSString stringWithFormat:@"%@", sender.titleLabel.text];
                [self.viewController changeWithArea:area];
            }
        }];
        
    }
}

@end
