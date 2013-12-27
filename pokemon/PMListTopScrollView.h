//
//  PMListTopScrollView.h
//  pokemon
//
//  Created by 白彝澄源 on 13-6-23.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PMListTopScrollView : UIScrollView <UIScrollViewDelegate> {
    NSInteger userSelectedChannelID;        //点击按钮选择名字ID
    UIImageView *bgImageView;
    UIImageView *shadowImageView;
}

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, weak) ViewController *viewController;

@end
