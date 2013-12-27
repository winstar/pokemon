//
//  TopScrollView.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface TopScrollView : UIScrollView <UIScrollViewDelegate>
{
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    UIImageView *shadowImageView;
    UIImageView *bgImageView;
}

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) Pokemon *currPokemon;
@property (nonatomic) NSInteger scrollViewSelectedChannelID;    //滑动列表选择名字ID

+ (TopScrollView *)shareInstance;
//滑动撤销选中按钮
- (void)setButtonUnSelect;
//滑动选择按钮
- (void)setButtonSelect;

@end
