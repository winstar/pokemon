//
//  RootScrollView.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootScrollView : UIScrollView <UIScrollViewDelegate> {
    CGFloat userContentOffsetX;
}

+ (RootScrollView *)shareInstance;
- (void)loadPMInfoById:(int)pmId Type:(int)type1;
- (void)resetView;
- (void)setController:(UIViewController *)controller;

@end
